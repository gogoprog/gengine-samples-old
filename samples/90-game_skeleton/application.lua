require 'game'

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

function Application:showPage(name, duration)
    gengine.gui.executeScript("showPage('" .. name .. "'," .. duration .. ");")
end

function Application:play()
    Application.guiFadeFunction = function(self) self:changeState('inGame') end
    self:showPage('hud', 500)
end

function Application:goToMenu()
    Application.guiFadeFunction = function(self) self:changeState('menu') end
    self:showPage('menu', 500)
end
