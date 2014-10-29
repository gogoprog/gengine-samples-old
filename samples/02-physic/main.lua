function init()
    gengine.application.setName("[gengine-samples] 02-physic")
    gengine.application.setExtent(640, 480)
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

    logoEntity:addComponent(
        ComponentPhysic(),
        {
            extent = vector2(256, 128),
            type = "dynamic"
        }
        )

    logoEntity.position:set(0,200)
    logoEntity:insert()
end

local total = 0

function update(dt)
    total = total + dt

    if gengine.input.keyboard:isJustUp(27) then
        gengine.application.quit()
    end
end

function stop()

end
