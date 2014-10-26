function init()
    gengine.application.setName("[gengine-tests] 01-sprite_batch")
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
            vector4(0, 20*32, 32, 32), -- Grass
            vector4(2*32, 20*32, 32, 32), -- Tree
            vector4(0, 10*32, 4*32, 5*32), -- Building
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
    if gengine.input.keyboard:isJustUp(27) then
        gengine.application.quit()
    end
end

function stop()

end
