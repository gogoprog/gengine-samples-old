require 'game'
require 'gui'

Application = Application or {

}

gengine.stateMachine(Application)

function Application:init()
    Game:init()
end

function Application:update(dt)
    self:updateState(dt)
end

function Application.onStateEnter:inMenu()
end

function Application.onStateUpdate:inMenu(dt)
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function Application.onStateExit:inMenu()
end

function Application.onStateEnter:inGame()
    Game:init()
    Game:changeState("running")
end

function Application.onStateUpdate:inGame(dt)
    Game:update(dt)
end

function Application.onStateExit:inGame()
    Game:finalize()
end

function Application:guiFadeFunction()
end
