
require 'application'

function init()
    gengine.application.setName("[gengine-samples] 90-game_skeleton")
    gengine.application.setExtent(800, 600)
    gengine.application.setFullscreen(false)
end


function start()
    gengine.graphics.setClearColor(0.5, 0.5, 0.5, 1)

    gengine.gui.loadFile("gui/main.html")

    Application:changeState("inMenu")
end

function update(dt)
    Application:update(dt)
end

function stop()
end
