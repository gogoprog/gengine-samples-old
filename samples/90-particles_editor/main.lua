function init()
    gengine.application.setName("[gengine-samples] 90-particles_editor")
    gengine.application.setExtent(1024, 768)
end

function start()
    gengine.graphics.setClearColor(0,0,0,1)

    gengine.graphics.texture.createFromDirectory("data/")

    gengine.gui.loadFile("gui/main.html")

    local e = gengine.entity.create()

    e:addComponent(
        ComponentParticleSystem(),
        {
            texture = gengine.graphics.texture.get("particle"),
            size = 10000,
            rate = 1000,
            emitterLifeTime = 1000,
            extentRange = {vector2(32,32), vector2(34,34)},
            lifeTimeRange = {0.5, 1},
            directionRange = {0, 2*3.14},
            speedRange = {100, 500},
            rotationRange = {0, 0},
            spinRange = {-10, 10},
            scales = {vector2(1, 1)},
            colors = {vector4(0.8,0.8,0.9,1), vector4(0.3,0.3,0.9,1), vector4(0,0,0,0)}
        }
        )

    e:insert()
end

function update(dt)
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()

end
