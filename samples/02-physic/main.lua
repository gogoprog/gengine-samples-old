function init()
    gengine.application.setName("[gengine-samples] 02-physic")
    gengine.application.setExtent(1280, 800)
end

local cameraEntity
local scene

function start()
    gengine.graphics.setClearColor(Color(0,0.1,0.1,1))

    scene = gengine.entity.getScene(0)

    scene:addComponent(
        ComponentPhysicsWorld2D(),
        {
            gravity = Vector2(0, -1000)
        },
        "physic"
        )

    cameraEntity = gengine.entity.create()
    cameraEntity:addComponent(
        ComponentCamera(),
        {
            orthoSize = 800,
            orthographic = true
        },
        "camera"
        )

    cameraEntity:insert()

    local e = gengine.entity.create()

    e:addComponent(
        ComponentStaticSprite2D(),
        {
            sprite = cache:GetResource("Sprite2D", "tile.png"),
            color = Color(0.5, 0.2, 0.2, 1),
            layer = -1
        }
        )

    e:addComponent(ComponentRigidBody2D())

    e:addComponent(
        ComponentCollisionBox2D(),
        {
            size = Vector2(64, 64),
            friction = 0.5
        }
        )

    e.position.y = -400
    e.scale.x = 100
    e.scale.y = 1
    e:insert()

    createBloc(0, 200)
end

function update(dt)
    if gengine.input.isMouseButtonDown(1) then
        local mousePosition = gengine.input.getMousePosition() / Vector2(1280, 800)
        local worldPosition = cameraEntity.camera:ScreenToWorldPoint(Vector3(mousePosition.x,mousePosition.y,0))

        if math.random() > 0.5 then
            createBloc(worldPosition.x, worldPosition.y)
        else
            createBall(worldPosition.x, worldPosition.y)
        end
    end

    if gengine.input.isMouseButtonDown(3) then
        local result = scene.physic:Raycast(
            Vector2(-1000, 0),
            Vector2(1000, 0)
            )

        for k, v in ipairs(result) do
            local e = gengine.entity.getFromNode(v.body.node)
            e:remove()
            gengine.entity.destroy(e)
        end
    end

    if gengine.input.isKeyJustDown(41) then
        gengine.application.quit()
    end
end

function stop()

end

function createBloc(x, y)
    local e = gengine.entity.create()

    e:addComponent(
        ComponentStaticSprite2D(),
        {
            sprite = cache:GetResource('Sprite2D', 'tile.png'),
            layer = 0
        }
        )

    e:addComponent(
        ComponentRigidBody2D(),
        {
            bodyType = BT_DYNAMIC
        }
        )

    e:addComponent(
        ComponentCollisionBox2D(),
        {
            size = Vector2(64, 64),
            density = 1.0,
            friction = 0.0,
            restitution = 0.1
        }
        )

    e.position = Vector3(x, y)
    e.scale = Vector3(0.25, 0.25)
    e:insert()

    return e
end

function createBall(x, y)
    local e = gengine.entity.create()

    e:addComponent(
        ComponentStaticSprite2D(),
        {
            sprite = cache:GetResource('Sprite2D', 'ball.png'),
            layer = 0
        }
        )

    e:addComponent(
        ComponentRigidBody2D(),
        {
            bodyType = BT_DYNAMIC
        }
        )

    e:addComponent(
        ComponentCollisionCircle2D(),
        {
            radius = 90,
            density = 1.0,
            friction = 1.0,
            restitution = 0.0
        }
        )

    e.position = Vector3(x, y)
    e.scale = Vector3(1,1,1) / 8
    e:insert()

    return e
end
