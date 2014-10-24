function init()
    gengine.application.setName("[gengine-tests] 01-sprite")
    gengine.application.setExtent(320,200)
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
        }
        )

    logoEntity:insert()
end

local total = 0

function update(dt)
    total = total + dt
    logoEntity.position.x = math.sin(total * 2) * 50

    if gengine.input.keyboard:isJustUp(27) then
        gengine.application.quit()
    end
end

function stop()

end
