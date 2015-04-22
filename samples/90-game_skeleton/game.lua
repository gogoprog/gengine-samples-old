
Game = Game or {
}

gengine.stateMachine(Game)

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
end

function Game.onStateExit:running()
    self.itIsRunning = false
end

function Game:isRunning()
    return self.itIsRunning
end
