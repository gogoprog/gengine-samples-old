function init()
    gengine.application.setName("[gengine-samples] 01-sprite")
    gengine.application.setExtent(320,200)
    gengine.application.setFullscreen(false)
end

local logoEntity

function start()
    gengine.graphics.setClearColor(Color(0,0,0.1));

    gengine.graphics.sprite.create("logo.png")

    logoEntity = gengine.entity.create()

    logoEntity:addComponent(
        ComponentSprite(),
        {
            sprite = gengine.graphics.sprite.get("logo"),
            layer = 0
        }
        )

    logoEntity:insert()
end

local total = 0

function update(dt)
    total = total + dt
    logoEntity.position.x = math.sin(total * 2) * 50
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()

end
