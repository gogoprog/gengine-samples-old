function init()
    gengine.application.setName("[gengine-samples] 01-sprite")
    gengine.application.setExtent(320,200)
    gengine.application.setFullscreen(false)
end

local logoEntity

function start()
    --gengine.graphics.setClearColor(0,0.1,0.1,1)

    --gengine.graphics.texture.create("logo.png")

    logoEntity = gengine.entity.create()

    logoEntity:addComponent(
        ComponentSprite(),
        {
            --texture = gengine.graphics.texture.get("logo"),
            texture = "logo.png",
            extent = vector2(256, 128),
            layer = 0
        }
        )

    logoEntity.scale = vector2(100, 100)
    logoEntity:insert()
end

local total = 0

function update(dt)
    total = total + dt
    logoEntity.position.x = math.sin(total * 2) * 50
    --[[if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end]]
end

function stop()

end
