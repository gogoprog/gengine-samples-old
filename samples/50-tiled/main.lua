ComponentBox = {}

function ComponentBox:init()
end

function ComponentBox:insert()
    print("Box with type " .. (self.type or "(none)"))
end

function ComponentBox:update(dt)
end

function ComponentBox:remove()
end

function createObject(o)
    print("Object at " .. o.x .. ", " .. o.y)
end

function init()
    gengine.application.setName("[gengine-samples] 50-tiled")
    gengine.application.setExtent(800,600)
end

function start()
    gengine.graphics.setClearColor(0.5,0.5,0.5,1)
    gengine.physics.createWorlds(1)
    gengine.physics:getWorld(1):setGravity(vector2(0,-100))

    local entities = gengine.tiled.createEntities("data/map.lua", vector2(-192, -192))

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
