function init()
    gengine.application.setName("[gengine-samples] 01-quad")
    gengine.application.setExtent(320,200)
end



function start()
    gengine.graphics.setClearColor(0,0.1,0.1,1)

    for i=1,32 do
        local e = gengine.entity.create()

        e:addComponent(
            ComponentQuad(),
            {
                color = vector4(math.random(),math.random(),math.random(),math.random()),
                extent = vector2(math.random(64,128), math.random(64,128)),
                layer = 0
            }
            )

        e.position:set(math.random(-160,160), math.random(-100,100))

        e:insert()
    end
end

local total = 0

function update(dt)
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()

end
