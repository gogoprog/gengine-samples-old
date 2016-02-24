function init()
    gengine.application.setName("[gengine-samples] 01-sprite")
    gengine.application.setExtent(320,200)
    gengine.application.setFullscreen(false)
end

local cameraEntity
local extent = Vector2(320, 200)

function start()
    gengine.graphics.setClearColor(Color(0,0,0.1));

    gengine.graphics.sprite.create("logo.png")

    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            sprite = gengine.graphics.sprite.get("logo"),
            layer = 0
        }
        )

    e:insert()

    cameraEntity = gengine.entity.create()

    cameraEntity:addComponent(
        ComponentCamera(),
        {
            extent = extent
        },
        "camera"
        )

    cameraEntity:insert()
end

function update(dt)

    if gengine.input.isKeyDown(81) then
        extent = extent * 0.99
        cameraEntity.camera.extent = extent
    end

    if gengine.input.isKeyDown(82) then
        extent = extent * 1.01
        cameraEntity.camera.extent = extent
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
