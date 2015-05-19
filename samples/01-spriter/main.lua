function init()
    gengine.application.setName("[gengine-samples] 01-spriter")
    gengine.application.setExtent(320,200)
end

local characterEntity
local leftAnimation, rightAnimation, loopingAnimation

function start()
    gengine.graphics.setClearColor(0,0.1,0.1,1)

    gengine.graphics.texture.createFromDirectory("data/")
    gengine.graphics.spriter.loadFile("data/example.scon")
end

function update(dt)
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()

end
