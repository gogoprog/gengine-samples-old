function init()
    gengine.application.setName("[gengine-samples] 50-tiled")
    gengine.application.setExtent(800,600)
end

function start()
    gengine.graphics.setClearColor(0.5,0.5,0.5,1)

    local entities = gengine.tiled.createEntities("data/map.lua")

    for k, e in ipairs(entities) do
        e:insert()
    end
end

function update(dt)
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()

end
