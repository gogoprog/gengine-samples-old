function init()
    gengine.application.setName("[gengine-samples] 00-input")
    gengine.application.setExtent(320,200)
end

local axisDeadZone = 0.2
local lastMousePosition
local lastHatValues = {{},{},{},{}}
local lastAxisValues = {{},{},{},{}}

function start()
    lastMousePosition = vector2()
end

function update(dt)
    for j=0,3 do
        if gengine.input:getJoypad(j):isConnected() then
            for b=0, gengine.input:getJoypad(j):getButtonCount() do
                if gengine.input:getJoypad(j):isJustDown(b) then
                    print("Joypad" .. j .. " button" .. b .. " is just pressed!")
                end
            end

            for a=0, gengine.input:getJoypad(j):getAxisCount() do
                local v = gengine.input:getJoypad(j):getAxis(a)
                if math.abs(v) > axisDeadZone and v ~= lastAxisValues[j+1][a] then
                    lastAxisValues[j+1][a] = v
                    print("Joypad" .. j .. " axis " .. a .. " value is now " .. v)
                end
            end

            for h=0, gengine.input:getJoypad(j):getHatCount() do
                local v = gengine.input:getJoypad(j):getHat(h)
                if v ~= lastHatValues[j+1][h] then
                    lastHatValues[j+1][h] = v
                    print("Joypad" .. j .. " hat " .. h .. " value is now " .. v)
                end
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

    local m = gengine.input.mouse:getPosition()

    if lastMousePosition.x ~= m.x or lastMousePosition.y ~= m.y then
        lastMousePosition:set(m)
        print("Mouse position is now " .. tostring(lastMousePosition))
    end

    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()
end
