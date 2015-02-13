function init()
    gengine.application.setName("[gengine-samples] 90-particles_editor")
    gengine.application.setExtent(1024, 768)
end

local e, ps
local cameraEntity
local parameters = {}

function start()
    gengine.graphics.setClearColor(0,0,0,1)

    gengine.graphics.texture.createFromDirectory("data/")

    gengine.gui.loadFile("gui/main.html")

    e = gengine.entity.create()

    e:addComponent(
        ComponentParticleSystem(),
        {
            texture = gengine.graphics.texture.get("particle"),
            size = 10000,
            keepLocal = false,
            emitterRate = 1000,
            emitterLifeTime = 1000,
            extentRange = {vector2(32,32), vector2(34,34)},
            lifeTimeRange = {0.5, 1},
            directionRange = {0, 2*3.14},
            speedRange = {100, 500},
            rotationRange = {0, 0},
            spinRange = {-10, 10},
            scales = {vector2(1, 1)},
            colors = {vector4(0.8,0.8,0.9,1), vector4(0.3,0.3,0.9,1), vector4(0,0,0,0)}
        },
        "ps"
        )

    e.position.x = 200
    e:insert()

    cameraEntity = gengine.entity.create()
    cameraEntity:addComponent(ComponentCamera(), { extent = vector2(1027, 768) }, "camera")
    cameraEntity:insert()

    ps = e.ps
end

function update(dt)
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end

    if gengine.input.mouse:isDown(3) then
        local x,y = gengine.input.mouse:getPosition()
        local wx, wy = cameraEntity.camera:getWorldPosition(x,y)

        e.position:set(wx, wy)
    end
end

function stop()

end

function updateValue(name, v)
    ps[name] = v
    parameters[name] = v
end

function updateRange(name, a, b)
    ps[name] = {a, b}
    parameters[name] = {a, b}
end
