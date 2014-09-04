dofile("game.lua")

function init()
    gengine.application.setName("[gengine-tests] 90-labyr")
    gengine.application.setExtent(800,800)
end

function start()
    gengine.graphics.setClearColor(0.6,0.6,0.6,1)

    Game:load()

    Game:start(10,10,32)
end

function update(dt)
    Game:update(dt)
end
