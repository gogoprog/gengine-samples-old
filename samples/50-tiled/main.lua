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
    gengine.graphics.setClearColor(Color(0.5,0.5,0.5,1))

    local scene = gengine.entity.getScene(0)

    scene:addComponent(
        ComponentPhysicsWorld2D(),
        {
            gravity = Vector2(0, -1000)
        },
        "physic"
        )

    local entities = gengine.tiled.createEntities("map.tmx")
    entities[1].position.x = -192
    entities[1].position.y = -192

    for _, e in ipairs(entities) do
        e:insert()
    end
end

function update(dt)
    if gengine.input.isKeyJustDown(41) then
        gengine.application.quit()
    end
end

function stop()

end
