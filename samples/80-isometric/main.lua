function init()
    gengine.application.setName("[gengine-tests] 80-isometric")
    gengine.application.setExtent(640,480)
end

local entity

function start()
    gengine.graphics.setClearColor(0,0.1,0.1,1)

    local texture = gengine.graphics.texture.create("tile_set.png") -- Loading the sprite sheet.

    gengine.graphics.atlas.create(
        "tile_set",
        texture,
        { 
            vector4(0, 0, 64, 64), -- Grass
            vector4(1*64, 0*64, 64, 64), -- Tree
            vector4(4*64, 5*64, 64, 64), -- Building
        }
        )

    entity = gengine.entity.create()

    entity:addComponent(
        ComponentSpriteBatch(),
        {
            atlas = gengine.graphics.atlas.get("tile_set"),
            size = 512,
            layer = 0
        },
        "Batch"
        )

    local batch = entity.Batch

    batch:lock()

    -- Fill the screen with grass
    for j=-240,240,32 do
        for i=-320,320,32 do
            batch:addItem(0, vector2(i, j))
        end
    end

    -- Put trees at random positions
    for i=1,10 do
        batch:addItem(1, vector2(math.random(-10,10) * 32, math.random(-10,10) * 32))
    end

    -- Put a building at random position
    batch:addItem(2, vector2(0, 0))

    batch:unlock()

    entity:insert()
end


function update(dt)
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()

end


function CarToIso(x, y)
    return x - y, (x + y) / 2
end

function IsoToCar(i, j)
    return (i + 2*j) /2, (2*j - i )/2
end