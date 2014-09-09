dofile("game.lua")

function init()
    gengine.application.setName("[gengine-tests] 90-labyr")
    gengine.application.setExtent(640, 480)
end

function start()
    gengine.graphics.setClearColor(1,1,1,1)
    gengine.gui.loadFile("gui/main.html")

    Game:load()
end

function update(dt)
    Game:update(dt)
end

function onStartClick()
    Game:start(10,10,32)
    gengine.gui.loadFile("about:blank")
end