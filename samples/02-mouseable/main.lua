function init()
    gengine.application.setName("[gengine-samples] 02-mouseable")
    gengine.application.setExtent(640,480)
end

local logoEntity

function start()
    gengine.graphics.setClearColor(Color(0,0.1,0.1,1))

    logoEntity = gengine.entity.create()

    logoEntity:addComponent(
        ComponentStaticSprite2D(),
        {
            sprite = cache:GetResource('Sprite2D', 'logo.png'),
            layer = 0
        },
        "sprite"
        )

    logoEntity:addComponent(
        ComponentMouseable(),
        {
            extent = Vector2(256, 64)
        },
        "mouseable"
        )

    logoEntity.onMouseEnter = function(e)
        e.sprite.color = Color(1,0,0,1)
    end

    logoEntity.onMouseExit = function(e)
        e.sprite.color = Color(1,1,1,1)
    end

    logoEntity.onMouseJustDown = function(e)
        e.position.y = e.position.y - 16
    end

    logoEntity.position.y = 128
    logoEntity:insert()
end

function update(dt)
    if gengine.input.isKeyJustDown(41) then
        gengine.application.quit()
    end
end

function stop()

end
