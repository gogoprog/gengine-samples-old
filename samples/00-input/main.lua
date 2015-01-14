function init()
    gengine.application.setName("[gengine-samples] 00-input")
    gengine.application.setExtent(320,200)
end

local lastMousePosition

function start()
    lastMousePosition = vector2()
end

function update(dt)
    for j=0,3 do
        for b=0, 10 do
            if gengine.input.joypads[j]:isJustDown(b) then
                print("Joypad" .. j .. " button" .. b .. " is just pressed!")
            end
        end
    end

    for b=1,3 do
        if gengine.input.mouse:isJustDown(b) then
            print("Mouse button " .. b .. " is just pressed!")
        end
    end

    for k=1,100 do
        if gengine.input.keyboard:isJustDown(k) then
            print("Keyboard key " .. k .. " is just pressed!")
        end
    end

    local x, y = gengine.input.mouse:getPosition()

    if lastMousePosition.x ~= x or lastMousePosition.y ~= y then
        lastMousePosition:set(x, y)
        print("Mouse position is now " .. tostring(lastMousePosition))
    end

    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()
end
