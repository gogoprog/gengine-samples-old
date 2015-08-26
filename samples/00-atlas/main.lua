function init()
    gengine.application.setName("[gengine-samples] 00-atlas")
    gengine.application.setExtent(320,200)
end


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

    gengine.graphics.atlas.create( -- Create another atlas.
        "atlas3",
        gengine.graphics.texture.create("atlas_border.png"),
        {
            width=64,
            height=64,
            spacing=1,
            margin=1
        }
        )

    local e

    e = gengine.entity.create()
    e:addComponent(
        ComponentSprite(),
        {
            atlas = gengine.graphics.atlas.get("atlas1"), -- Will use the given atlas.
            atlasItem = 1, -- Using the cell at index 0. (index starts from 0)
            extent = vector2(128, 128),
            layer = 0
        }
        )
    e.position.x = - 80
    e:insert()

    e = gengine.entity.create()
    e:addComponent(
        ComponentSprite(),
        {
            atlas = gengine.graphics.atlas.get("atlas2"), -- Will use the given atlas.
            atlasItem = 0, -- Using the cell at index 0.
            extent = vector2(128, 128),
            layer = 0
        }
        )
    e.position.x = 80
    e:insert()

    e = gengine.entity.create()
    e:addComponent(
        ComponentSprite(),
        {
            atlas = gengine.graphics.atlas.get("atlas3"),
            atlasItem = 1,
            extent = vector2(64, 64),
            layer = 1
        }
        )
    e.position.x = 0
    e:insert()

    e = gengine.entity.create()
    e:addComponent(
        ComponentSprite(),
        {
            atlas = gengine.graphics.atlas.get("atlas3"),
            atlasItem = 0,
            extent = vector2(64, 64),
            layer = 1
        }
        )
    e.position.x = -64
    e:insert()

    e = gengine.entity.create()
    e:addComponent(
        ComponentSprite(),
        {
            atlas = gengine.graphics.atlas.get("atlas3"),
            atlasItem = 2,
            extent = vector2(64, 64),
            layer = 1
        }
        )
    e.position.x = 64
    e:insert()
end

function update(dt)
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()
end
