
IsometricMap = {
    cellSize = 32,
    mapSize = 100,
    heights = {},
    miniheights = {},
    minifactor = 1,
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

function IsometricMap:generateGrounds()
    local minifactor = self.minifactor
    for j=0, self.mapSize / minifactor - 1  do
        for i=0, self.mapSize / minifactor - 1 do
            self.miniheights[j*(self.mapSize / minifactor) + i] = math.random(-1, 0)
        end
    end

    for j=0, self.mapSize - 1  do
        for i=0, self.mapSize - 1 do
            self.heights[j*self.mapSize + i] = self.miniheights[math.floor(j/minifactor)*(self.mapSize/minifactor) + math.floor(i/minifactor)]
        end
    end

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

            for k, v in pairs(self.heightTiles) do
                if k[1] == deltas[1] and k[2] == deltas[2] and k[3] == deltas[3] and k[4] == deltas[4] then
                    tileIndex = v
                end
            end

            local h = 0

            batch:addItem(tileIndex, self:getIsoFromCar(i, j) * self.cellSize + vector2(0, h * self.cellSize))
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
end


function update(dt)
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end

    local mx, my = gengine.input.mouse:getPosition()

    if gengine.input.mouse:isDown(1) then
        local dx, dy = lastMouseX - mx, lastMouseY - my

        cameraEntity.position.x = cameraEntity.position.x + dx
        cameraEntity.position.y = cameraEntity.position.y - dy
    end

    lastMouseX = mx
    lastMouseY = my
end

function stop()

end


