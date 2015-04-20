print("tests/basic")

ComponentCustom = {}

function ComponentCustom:init()
    self.entity.sprite.color = vector4(0.3,0.3,0.3,1)
end

function ComponentCustom:insert()
end

function ComponentCustom:update(dt)
end

function ComponentCustom:remove()
end

function ComponentCustom:onMouseEnter()
    self.entity.sprite.color = vector4(1,1,1,1)
end

function ComponentCustom:onMouseExit()
    self.entity.sprite.color = vector4(0.3,0.3,0.3,1)
end

function ComponentCustom:onMouseJustDown()
    self.entity.sprite.color = vector4(1,0,0,1)
end

function init()
    gengine.application.setName("gengine-samples] 80-basic")
    gengine.application.setExtent(640,480)
end

local e, cameraEntity

function start()
    print("tests/basic start")

    gengine.graphics.setClearColor(1,1,0.1,1)

    gengine.graphics.texture.createFromDirectory(".")

    e = gengine.entity.create()
    e.name = "Yeah"

    e:addComponent(ComponentSprite(), { texture = gengine.graphics.texture.get("logo"), extent = vector2(256, 128) }, "sprite")
    e:addComponent(ComponentMouseable(), { extent = vector2(256, 128) })
    e:addComponent(ComponentCustom(), {}, "custom")

    e:insert()

    cameraEntity = gengine.entity.create()
    cameraEntity:addComponent(ComponentCamera(), { extent = vector2(640, 480) }, "camera")
    cameraEntity:insert()
end

local total = 0
local layer = 0
local my_entities = {}

function update(dt)
    total = total + dt

    gengine.graphics.setClearColor(1,1,math.sin(total),1)

    if gengine.input.mouse:isJustDown(1) then
        local mousePosition = gengine.input.mouse:getPosition()
        local worldPosition = cameraEntity.camera:getWorldPosition(mousePosition)

        local et
        et = gengine.entity.create()
        et:addComponent(ComponentSprite(),
            {
                texture = gengine.graphics.texture.get("bird"),
                layer = layer,
                extent = vector2(64, 64),
                color = vector4(0.5,0.9,0.6,1)
            })

        et:insert()
        et.position:set(worldPosition)

        layer = layer + 1

        table.insert(my_entities, et)
    end

    for k,v in ipairs(my_entities) do
        v.rotation = v.rotation + dt
    end

    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()
    print("tests/basic end")
end
