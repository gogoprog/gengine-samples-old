
IsometricMap = {
    cellSize = 32,
    mapSize = 50,
    heights = {},
    heightTiles = {}
}

function IsometricMap:init()
    local texture = gengine.graphics.texture.create("tile_set.png") -- Loading the sprite sheet.

    gengine.graphics.atlas.create(
        "tiles",
        texture,
        {
            vector4(0*64, 3*64, 64, 64),
            vector4(1*64, 3*64, 64, 64),
            vector4(2*64, 3*64, 64, 64),
            vector4(3*64, 3*64, 64, 64),
            vector4(4*64, 3*64, 64, 64),
            vector4(5*64, 3*64, 64, 64),
            vector4(6*64, 3*64, 64, 64),
            vector4(7*64, 3*64, 64, 64),
            vector4(8*64, 3*64, 64, 64),

            vector4(0*64, 4*64, 64, 64),
            vector4(1*64, 4*64, 64, 64),
            vector4(2*64, 4*64, 64, 64),
            vector4(3*64, 4*64, 64, 64),

            vector4(3*64, 0*64, 64, 64),
        }
        )

    self.heightTiles[{0, -1, -1, -1}] = 0
    self.heightTiles[{0, 0, -1, -1}] = 1
    self.heightTiles[{0, -1, -1, 0}] = 2
    self.heightTiles[{-1, 0, -1, -1}] = 3
    self.heightTiles[{0, 0, 0, 0}] = 4
    self.heightTiles[{-1, -1, -1, 0}] = 5
    self.heightTiles[{-1, 0, 0, -1}] = 6
    self.heightTiles[{-1, -1, 0, 0}] = 7
    self.heightTiles[{-1, -1, 0, -1}] = 8
    self.heightTiles[{-1, 0, 0, 0}] = 9
    self.heightTiles[{0, -1, 0, 0}] = 10
    self.heightTiles[{0, 0, -1, 0}] = 11
    self.heightTiles[{0, 0, 0, -1}] = 12
    self.heightTiles[{-1, -1, -1, -1}] = 13

    self.groundEntity = gengine.entity.create()

    self.groundEntity:addComponent(
        ComponentSpriteBatch(),
        {
            atlas = gengine.graphics.atlas.get("tiles"),
            size = self.mapSize * self.mapSize * 2,
            layer = 1
        },
        "Batch"
        )

    self.groundEntity:insert()

    for j=0, self.mapSize - 1  do
        for i=0, self.mapSize - 1 do
            self.heights[j*self.mapSize + i] = 0
        end
    end

    self:generateGrounds()
end

function IsometricMap:getIsoFromCar(x, y)
    return vector2(x - y, (x + y) / 2)
end

function IsometricMap:getCarFromIso(i, j)
    return vector2((i + 2*j) /2, (2*j - i )/2)
end

function IsometricMap:getHeight(i, j)
    return self.heights[j*self.mapSize + i]
end

function IsometricMap:setHeight(i, j, h)
    if self:isValidCoord(i, j) then
        self.heights[j*self.mapSize + i] = h
        return h
    end

    return nil
end

function IsometricMap:isValidCoord(i, j)
    return i > 0 and i < self.mapSize and j > 0 and j < self.mapSize
end

function IsometricMap:incrementHeight(i, j)
    if self:isValidCoord(i, j) then
        return self:setHeight(i, j, self:getHeight(i, j) + 1)
    end

    return nil
end

function IsometricMap:compareAndGrow(i, j, di, dj)
    if self:isValidCoord(i, j) and self:isValidCoord(i + di, j + dj) then
        local h = self:getHeight(i, j)
        if h and h - self:getHeight(i + di, j + dj) > 1 then
            self:grow(i + di, j + dj)
        end
    end
end

function IsometricMap:grow(i, j)
    self:incrementHeight(i, j)
    self:compareAndGrow(i, j, 1, 0)
    self:compareAndGrow(i, j, -1, 0)
    self:compareAndGrow(i, j, 0, 1)
    self:compareAndGrow(i, j, 0, -1)
    self:compareAndGrow(i, j, 1, -1)
    self:compareAndGrow(i, j, -1, -1)
    self:compareAndGrow(i, j, 1, 1)
    self:compareAndGrow(i, j, -1, 1)
end

function IsometricMap:randomizeHeights()
    for j=0, self.mapSize - 1  do
        for i=0, self.mapSize - 1 do
            self.heights[j*self.mapSize + i] = 0
        end
    end

    for n=1, 100 do
        local c = math.random(1, 2)
        local i = math.random(1, self.mapSize - 1)
        local j = math.random(1, self.mapSize - 1)
        for _=1,c do
            self:grow(i, j)
        end
    end
end

function IsometricMap:generateGrounds()
    local batch = self.groundEntity.Batch

    batch:lock()

    for j=self.mapSize - 1, 1, -1 do
        for i=self.mapSize - 1, 1, -1 do
            local height = self:getHeight(i, j)
            local tileIndex = 13

            local deltas = {}

            deltas[1] = height
            deltas[2] = self:getHeight(i, j-1)
            deltas[3] = self:getHeight(i-1, j-1)
            deltas[4] = self:getHeight(i-1, j)

            local max = math.max(math.max(math.max(deltas[1], deltas[2]), deltas[3]), deltas[4])

            deltas[1] = deltas[1] - max
            deltas[2] = deltas[2] - max
            deltas[3] = deltas[3] - max
            deltas[4] = deltas[4] - max

            for k, v in pairs(self.heightTiles) do
                if k[1] == deltas[1] and k[2] == deltas[2] and k[3] == deltas[3] and k[4] == deltas[4] then
                    tileIndex = v
                end
            end

            for h=0, max - 1 do
                batch:addItem(4, self:getIsoFromCar(i, j) * self.cellSize + vector2(0, h * self.cellSize))
            end

            batch:addItem(tileIndex, self:getIsoFromCar(i, j) * self.cellSize + vector2(0, (max) * self.cellSize))
        end
    end

    batch:unlock()
end

local cameraEntity, lastMouseX, lastMouseY

function init()
    gengine.application.setName("[gengine-samples] 80-isometric")
    gengine.application.setExtent(1024,640)
end

function start()
    gengine.graphics.setClearColor(0,0.1,0.1,1)

    IsometricMap:init()

    cameraEntity = gengine.entity.create()
    cameraEntity:addComponent(
        ComponentCamera(),
        {
            extent = vector2(1024, 640)
        },
        "camera"
        )
    cameraEntity:insert()
    cameraEntity.position.y = 300
end


function update(dt)
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end

    local mousePosition = gengine.input.mouse:getPosition()

    if gengine.input.mouse:isDown(3) then
        local dx, dy = lastMouseX - mousePosition.x, lastMouseY - mousePosition.y

        cameraEntity.position.x = cameraEntity.position.x + dx
        cameraEntity.position.y = cameraEntity.position.y - dy
    end

    if gengine.input.mouse:isJustDown(1) then
        local worldPosition = cameraEntity.camera:getWorldPosition(mousePosition)
        local worldPosition = IsometricMap:getCarFromIso(worldPosition.x, worldPosition.y)
        IsometricMap:grow(math.floor(worldPosition.x / IsometricMap.cellSize), math.floor(worldPosition.y / IsometricMap.cellSize))

        IsometricMap:generateGrounds()
    end

    if gengine.input.keyboard:isDown(44) then
        IsometricMap:randomizeHeights()
        IsometricMap:generateGrounds()
    end

    lastMouseX = mousePosition.x
    lastMouseY = mousePosition.y
end

function stop()

end


