require 'factory'

Game = Game or {
    objects = {}
}

gengine.stateMachine(Game)

function Game:init(dt)
    Factory:init()
    self.timeSinceLast = 10
end

function Game:finalize()
    for k, v in ipairs(self.objects) do
        v:remove()
    end

    self.objects = {}

    Factory:finalize()
end

function Game:update(dt)
    self:updateState(dt)
end

function Game.onStateEnter:none()
end

function Game.onStateUpdate:none(dt)
end

function Game.onStateExit:none()
end

function Game.onStateEnter:running()
    self.itIsRunning = true
end

function Game.onStateUpdate:running(dt)
    self.timeSinceLast = self.timeSinceLast + dt

    if self.timeSinceLast >= 1.0 then
        local e = Factory:createObject(math.random(-300, 300), math.random(-200, 200))
        e:insert()
        table.insert(self.objects, e)
        self.timeSinceLast = 0
        gengine.gui.executeScript("updateObjects(" .. #self.objects .. ")")
    end

    if gengine.input.mouse:isJustDown(1) then
        local index = math.random(1, #self.objects)
        self.objects[index]:remove()
        table.remove(self.objects, index)
        gengine.gui.executeScript("updateObjects(" .. #self.objects .. ")")

        if #self.objects == 0 then
            Application:goToMenu()
            self:changeState("none")
        end
    end
end

function Game.onStateExit:running()
    self.itIsRunning = false
end

function Game:isRunning()
    return self.itIsRunning
end
