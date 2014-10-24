function init()
    gengine.application.setName("[gengine-tests] 02-mouseable")
    gengine.application.setExtent(640,480)
end

local logoEntity

function start()
    gengine.graphics.setClearColor(0,0.1,0.1,1)

    gengine.graphics.texture.create("logo.png")

    logoEntity = gengine.entity.create()

    logoEntity:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("logo"),
            extent = vector2(256, 128),
            layer = 0
        },
        "sprite"
        )

    logoEntity:addComponent(
        ComponentMouseable(),
        {
            extent = vector2(256, 128),
        },
        "mouseable"
        )

    logoEntity.onMouseEnter = function(e)
        local extent = vector2(300, 140)
        e.sprite.extent = extent
        e.mouseable.extent = extent
        e.sprite.color = {x=1,y=0,z=0,w=1}
    end

    logoEntity.onMouseExit = function(e)
        local extent = vector2(256, 128)
        e.sprite.extent = extent
        e.mouseable.extent = extent
        e.sprite.color = vector4(1,1,1,1)
    end

    logoEntity.onMouseJustDown = function(e)
        e.position.y = e.position.y - 16
    end

    logoEntity.position.y = 128
    logoEntity:insert()
end

function update(dt)
    if gengine.input.keyboard:isJustUp(27) then
        gengine.application.quit()
    end
end

function stop()

end
