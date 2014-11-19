function init()
    gengine.application.setName("[gengine-tests] 00-atlas")
    gengine.application.setExtent(320,200)
end

local entity, entity2

function start()
    gengine.graphics.setClearColor(0,0.1,0.1,1)

    local texture = gengine.graphics.texture.create("logo.png") -- Create a new texture.

    gengine.graphics.atlas.create("atlas1", texture, 2, 1) -- Create a new atlas using the given texture that will be divided in 5x1 cells.

    gengine.graphics.atlas.create( -- Create another atlas.
        "atlas2",
        texture,
        {
            vector4(10, 0, 64, 32),  -- Specify custom cells.
            vector4(74, 0, 64, 32)   -- (x, y, width, height)
        }
        )


    entity = gengine.entity.create()
    entity2 = gengine.entity.create()

    entity:addComponent(
        ComponentSprite(),
        {
            atlas = gengine.graphics.atlas.get("atlas1"), -- Will use the given atlas.
            atlasItem = 1, -- Using the cell at index 0. (index starts from 0)
            extent = vector2(128, 128),
            layer = 0
        }
        )

    entity.position.x = - 80
    entity:insert()

    entity2:addComponent(
        ComponentSprite(),
        {
            atlas = gengine.graphics.atlas.get("atlas2"), -- Will use the given atlas.
            atlasItem = 0, -- Using the cell at index 0.
            extent = vector2(128, 128),
            layer = 0
        }
        )

    entity2.position.x = 80
    entity2:insert()
end

function update(dt)
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()
end
