function init()
    gengine.application.setName("[gengine-samples] 01-static_sprite_2d")
    gengine.application.setExtent(320,200)
    gengine.application.setFullscreen(false)
end

local logoEntity

function start()
    gengine.graphics.setClearColor(Color(0,0,0.1));

    logoEntity = gengine.entity.create()

    logoEntity:addComponent(
        ComponentStaticSprite2D(),
        {
            sprite = cache:GetResource("Sprite2D", "logo.png"),
            layer = 0
        },
        "sprite"
        )

    logoEntity:insert()
end

local total = 0

function update(dt)
    total = total + dt
    logoEntity.position.x = math.sin(total * 2) * 50
    logoEntity.sprite.alpha = (math.sin(total * 5) + 1) * 0.5
    if gengine.input.isKeyDown(41) then
        gengine.application.quit()
    end
end

function stop()

end
