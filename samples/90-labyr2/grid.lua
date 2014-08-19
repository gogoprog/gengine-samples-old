dofile("component_placer.lua")

Grid = Grid or {
    tiles = {}
}

function Grid:init(w, h, tileSize)
    self.width = w
    self.height = h
    self.tileSize = tileSize

    self.origin = {
        tileSize * ( w - 1 ) * -0.5,
        tileSize * ( h - 1 ) * -0.5
        }

    self:initPlacers()
end

function Grid:getTilePosition(i, j)
    local origin = self.origin

    return origin[1] + i * self.tileSize, origin[2] + j * self.tileSize
end

function Grid:fill()
    for i=0,self.width - 1 do
        for j=0,self.height - 1 do
            local e
            e = entity.create()

            e:addComponent(
                ComponentSprite(),
                {
                    texture = graphics.texture.get("tile0"),
                    extent = { x=self.tileSize, y=self.tileSize },
                    layer = 0
                },
                "sprite"
                )

            self:setTile(i, j, e)

            e:insert()
        end
    end
end

function Grid:setTile(i, j, e)
    if self.tiles[i] == nil then
        self.tiles[i] = {}
    end

    self.tiles[i][j] = e

    local x, y = self:getTilePosition(i, j)

    e.position.x = x
    e.position.y = y
end


function Grid:createPlacer(i, j)
    local e
    e = entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = graphics.texture.get("tile0"),
            extent = { x=self.tileSize, y=self.tileSize },
            layer = 0
        },
        "sprite"
        )

    e:addComponent(
        ComponentPlacer(),
        {
        },
        "placer"
        )
    
    e:addComponent(
        ComponentMouseable(),
        {
            extent = { x=self.tileSize, y=self.tileSize }
        }
        )

    e:insert()

    local x, y = self:getTilePosition(i, j)

    e.position.x = x
    e.position.y = y

    return e
end

function Grid:initPlacers()
    local w = self.width -1
    local h = self.height -1

    local i = -1
    for j=0,h do
        local e = self:createPlacer(i, j)
        e.placer.row = j
        e.placer.sens = 1
    end

    i = w + 1
    for j=0,h do
        local e = self:createPlacer(i, j)
        e.placer.row = j
        e.placer.sens = -1
    end

    local j = -1
    for i=0,w do
        local e = self:createPlacer(i, j)
        e.placer.col = i
        e.placer.sens = 1
    end

    j = h + 1
    for i=0,w do
        local e = self:createPlacer(i, j)
        e.placer.col = i
        e.placer.sens = -1
    end
end