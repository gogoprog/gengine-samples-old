function init()
    gengine.application.setName("[gengine-samples] 01-text")
    gengine.application.setExtent(640,480)
end


function start()
    gengine.graphics.setClearColor(0.0,0.0,0.0,1)

    local font =  gengine.graphics.font.create("arial.ttf", 32)

    local e = gengine.entity.create()

    e:addComponent(
        ComponentText(),
        {
            text = "Hello World!",
            font = font,
            color = vector4(1,1,1,1)
        }
        )

    e:insert()

    e.position.y = 200
end

function update(dt)
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()
end
