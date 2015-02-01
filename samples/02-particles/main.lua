function init()
    gengine.application.setName("[gengine-samples] 02-particles")
    gengine.application.setExtent(512, 512)
end

local entity

function start()
    gengine.graphics.setClearColor(0,0.1,0.1,1)

    gengine.graphics.texture.create("particle.png")

    entity = gengine.entity.create()

    entity:addComponent(
        ComponentParticleSystem(),
        {
            texture = gengine.graphics.texture.get("particle"),
            size = 100,
            rate = 30
        }
        )

    entity:insert()
end

function update(dt)
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()

end
