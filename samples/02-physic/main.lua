function init()
    gengine.application.setName("[gengine-samples] 02-physic")
    gengine.application.setExtent(640, 480)
end

local worldEntity

function start()
    gengine.graphics.setClearColor(Color(0,0.1,0.1,1))

    worldEntity = gengine.entity.create()
    worldEntity:addComponent(
        ComponentCamera(),
        {
            orthoSize = 480,
            orthographic = true
        },
        "camera"
        )

    worldEntity:addComponent(
        ComponentPhysicsWorld2D(),
        {
            gravity = Vector2(500, 0)
        },
        "physic"
        )

    worldEntity:insert()

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

    e.position.y = -200
    e.scale.x = 100
    e.scale.y = 1
    e:insert()

    blo = createBloc(0, 200)
end

function update(dt)
    print(blo.position.y)
    if gengine.input.isMouseButtonDown(1) then
        local mousePosition = gengine.input.getMousePosition()
        --[[local worldPosition = worldEntity.camera:getWorldPosition(mousePosition)

        if math.random() > 0.5 then
            createBloc(worldPosition.x, worldPosition.y)
        else
            createBall(worldPosition.x, worldPosition.y)
        end]]
    end

    if gengine.input.isMouseButtonDown(3) then
        --[[gengine.physics.worlds[1]:rayCast(
            vector2(-1000, 0),
            vector2(1000, 0),
            function(e)
                e:remove()
                gengine.entity.destroy(e)
            end
            )]]
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
            friction = 0.5,
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
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("ball"),
            extent = vector2(32, 32),
            layer = 0
        }
        )

    e:addComponent(
        ComponentPhysic(),
        {
            radius = 10,
            type = "dynamic",
            density = 1,
            friction = 1.3
        }
        )

    e.position:set(x, y)
    e:insert()

    return e
end
