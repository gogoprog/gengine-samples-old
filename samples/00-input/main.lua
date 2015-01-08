function init()
    gengine.application.setName("[gengine-samples] 00-input")
    gengine.application.setExtent(320,200)
end

local connectedJoypads = {}

function start()

end

function update(dt)

    for j=0,3 do
        for b=0, 10 do
            if gengine.input.joypads[j]:isJustDown(b) then
                print("Joypad" .. j .. " button" .. b .. " is just pressed!")
            end
        end
    end

    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()
end
