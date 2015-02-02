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
            size = 1000,
            rate = 1,
            emitterLifeTime = 1000,
            extentRange = {vector2(64,64), vector2(128,128)},
            lifeTimeRange = {1, 2},
            directionRange = {0, 2*3.14},
            speedRange = {100, 500},
            rotationRange = {0, 0},
            spinRange = {0, 10},
            scales = {vector2(1, 1)},
            colors = {vector4(1,1,1,1), vector4(1,1,1,0)}
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
