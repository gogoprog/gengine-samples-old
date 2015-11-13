function init()
    gengine.application.setName("[gengine-samples] 01-spine")
    gengine.application.setExtent(800,600)
end


function start()
    gengine.graphics.setClearColor(0,0.1,0.1,1)
    gengine.graphics.texture.createFromDirectory("data/")
    gengine.graphics.spine.create("data/raptor.json")
end

function update(dt)
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()

end
