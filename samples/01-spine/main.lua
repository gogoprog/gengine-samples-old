function init()
    gengine.application.setName("[gengine-samples] 01-spine")
    gengine.application.setExtent(800,600)
end

local boy, raptor

function start()
    gengine.graphics.setClearColor(0,0.1,0.1,1)
    gengine.graphics.texture.createFromDirectory("data/")
    gengine.graphics.spine.create("data/spineboy.json")
    gengine.graphics.spine.create("data/raptor.json")

    boy = gengine.entity.create()

    boy:addComponent(
        ComponentSpine(),
        {
            layer = 0
        },
        "spine"
        )

    boy.scale:set(0.3, 0.3)
    boy.position:set(-300, -300)
    boy:insert()

    boy.spine:setAnimation(gengine.graphics.spine.get("spineboy-walk"), 0, true)

    raptor = gengine.entity.create()

    raptor:addComponent(
        ComponentSpine(),
        {
            layer = 0
        },
        "spine"
        )

    raptor.scale:set(-0.3, 0.3)
    raptor.position:set(100, -300)
    raptor:insert()

    raptor.spine:setAnimation(gengine.graphics.spine.get("raptor-walk"), 0, true)
end

function update(dt)
    if gengine.input.mouse:isJustDown(1) then
        boy.spine:setAnimation(gengine.graphics.spine.get("spineboy-shoot"), 0, false, 0)
        boy.spine:addAnimation(gengine.graphics.spine.get("spineboy-run"), 0, true, 0)
    end
    if gengine.input.mouse:isJustDown(3) then
        boy.spine:setAnimation(gengine.graphics.spine.get("spineboy-jump"), 0, false, 0)
        boy.spine:addAnimation(gengine.graphics.spine.get("spineboy-walk"), 0, true, 0)
    end
    if gengine.input.keyboard:isJustDown(44) then
        boy.spine:setAnimation(gengine.graphics.spine.get("raptor-walk"), 0, true)
    end
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()

end
