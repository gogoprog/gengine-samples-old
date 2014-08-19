Grid = Grid or {}

function Grid:init(w, h, tileSize)
    self.width = w
    self.height = h
    self.tileSize = tileSize

    self.origin = {
        tileSize * ( w - 1 ) * -0.5,
        tileSize * ( h - 1 ) * -0.5
        }
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

            local x, y = self:getTilePosition(i, j)

            e.position.x = x
            e.position.y = y

            e:insert()
        end
    end
end