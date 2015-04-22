require 'game'

Application = Application or {

}

gengine.stateMachine(Application)


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
end

function Application.onStateUpdate:inGame(dt)

end

function Application.onStateExit:inGame()
end
