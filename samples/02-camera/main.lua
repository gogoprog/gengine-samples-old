function init()
    gengine.application.setName("[gengine-samples] 01-sprite")
    gengine.application.setExtent(320,200)
    gengine.application.setFullscreen(false)
end

local cameraEntity
local orthoSize = 200

function start()
    gengine.graphics.setClearColor(Color(0,0,0.1));

    local e = gengine.entity.create()

    e:addComponent(
        ComponentStaticSprite2D(),
        {
            sprite = cache:GetResource("Sprite2D", "logo.png"),
            layer = 0
        }
        )

    e:insert()

    cameraEntity = gengine.entity.create()

    cameraEntity:addComponent(
        ComponentCamera(),
        {
            orthographic = true,
            orthoSize = orthoSize
        },
        "camera"
        )

    cameraEntity:insert()
end

function update(dt)

    if gengine.input.isKeyDown(81) then
        orthoSize = orthoSize * 0.99
        cameraEntity.camera.orthoSize = orthoSize
    end

    if gengine.input.isKeyDown(82) then
        orthoSize = orthoSize * 1.01
        cameraEntity.camera.orthoSize = orthoSize
    end

    if gengine.input.isKeyDown(80) then
        cameraEntity.position.x = cameraEntity.position.x + 100 * dt
    end

    if gengine.input.isKeyDown(79) then
        cameraEntity.position.x = cameraEntity.position.x - 100 * dt
    end

    if gengine.input.isKeyDown(41) then
        gengine.application.quit()
    end
end

function stop()

end
