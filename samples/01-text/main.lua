function init()
    gengine.application.setName("[gengine-samples] 01-text")
    gengine.application.setExtent(640,480)
end


function start()
    gengine.graphics.setClearColor(0.5,0.5,0.5,1)

    local font =  gengine.graphics.font.create("American Captain.ttf", 32)

    local e = gengine.entity.create()

    e:addComponent(
        ComponentText(),
        {
            text = "Hello World!",
            font = font
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
