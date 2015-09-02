function init()
    gengine.application.setName("[gengine-samples] 01-spriter")
    gengine.application.setExtent(800,600)
end

local e
local leftAnimation, rightAnimation, loopingAnimation

function start()
    gengine.graphics.setClearColor(0,0.1,0.1,1)

    gengine.graphics.texture.createFromDirectory("data/")
    gengine.graphics.spriter.create("data/example.scon")

    e = gengine.entity.create()

    e:addComponent(
        ComponentSpriter(),
        {
            layer = 0
        },
        "spriterComponent"
        )

    e:insert()

    local spriterComponent = e.spriterComponent
    spriterComponent:pushAnimation(gengine.graphics.spriter.get("Player-walk"))
end

function update(dt)

    if gengine.input.keyboard:isJustDown(44) then
        local spriterComponent = e.spriterComponent
        spriterComponent:pushAnimation(gengine.graphics.spriter.get("Player-crouch_down"))
        spriterComponent:pushAnimation(gengine.graphics.spriter.get("Player-stand_up"))
        spriterComponent:pushAnimation(gengine.graphics.spriter.get("Player-crouch_idle"))
        spriterComponent:pushAnimation(gengine.graphics.spriter.get("Player-jump_start"))
        spriterComponent:pushAnimation(gengine.graphics.spriter.get("Player-fall_start"))
    end

    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()

end
