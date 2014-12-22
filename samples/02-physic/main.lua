function init()
    gengine.application.setName("[gengine-samples] 02-physic")
    gengine.application.setExtent(640, 480)
end

local cameraEntity

function start()
    gengine.graphics.setClearColor(0,0.1,0.1,1)

    gengine.graphics.texture.create("tile.png")
    gengine.graphics.texture.create("ball.png")

    gengine.physics.createWorlds(1)
    gengine.physics:getWorld(1):setGravity(vector2(0,-100))

    cameraEntity = gengine.entity.create()
    cameraEntity:addComponent(ComponentCamera(), { extent = vector2(640, 480) }, "camera")
    cameraEntity:insert()

    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("tile"),
            color = vector4(0.5, 0.2, 0.2, 1),
            extent = vector2(640, 640),
            uvScale = vector2(20, 20),
            layer = -1
        }
        )

    e:addComponent(
        ComponentPhysic(),
        {
            extent = vector2(640, 640),
            type = "static"
        }
        )

    e.position:set(0,-500)
    e:insert()

    createBloc(0, 200)
end

function update(dt)
    if gengine.input.mouse:isDown(1) then
        local x,y = gengine.input.mouse:getPosition()
        local wx, wy = cameraEntity.camera:getWorldPosition(x,y)

        if math.random() > 0.5 then
            createBloc(wx, wy)
        else
            createBall(wx, wy)
        end
    end

    if gengine.input.mouse:isDown(3) then
        gengine.physics.worlds[1]:rayCast(
            vector2(-1000, 0),
            vector2(1000, 0),
            function(e)
                e:remove()
                gengine.entity.destroy(e)
            end
            )
    end

    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()

end

function createBloc(x, y)
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("tile"),
            extent = vector2(16, 16),
            layer = 0
        }
        )

    e:addComponent(
        ComponentPhysic(),
        {
            extent = vector2(16, 16),
            type = "dynamic",
            density = 1,
            friction = 1.3
        }
        )

    e.position:set(x, y)
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
