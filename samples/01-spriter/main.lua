function init()
    gengine.application.setName("[gengine-samples] 01-spriter")
    gengine.application.setExtent(800,600)
end

local e
local leftAnimation, rightAnimation, loopingAnimation

function start()
    gengine.graphics.setClearColor(0,0.1,0.1,1)

    gengine.graphics.texture.createFromDirectory("data/")
    gengine.graphics.spriter.loadFile("data/example.scon")

    e = gengine.entity.create()

    e:addComponent(
        ComponentSpriter(),
        {
            animation = gengine.graphics.spriter.get("Player-idle"),
            layer = 0
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
