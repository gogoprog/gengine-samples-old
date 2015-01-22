function init()
    gengine.application.setName("[gengine-samples] 02-navigation")
    gengine.application.setExtent(640, 480)
end

local cameraEntity
local agentEntity

function start()
    gengine.graphics.setClearColor(0,0.1,0.1,1)

    gengine.graphics.texture.create("tile.png")
    gengine.graphics.texture.create("ball.png")

    cameraEntity = gengine.entity.create()
    cameraEntity:addComponent(ComponentCamera(), { extent = vector2(640, 480) }, "camera")
    cameraEntity:insert()

    gengine.navigation.createWorlds(1)
    gengine.navigation:getWorld(1):init(10, 10, 32, 32)

    agentEntity = createAgent(5, 5)

    agentEntity.navigationAgent:moveTo(vector2(200, 200))
end

function update(dt)
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()
end

function createAgent(x, y)
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
        ComponentNavigationAgent(),
        {
            radius = 10,
            speed = 50
        },
        "navigationAgent"
        )

    e.position:set(x, y)
    e:insert()

    return e
end
