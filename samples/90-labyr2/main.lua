dofile("game.lua")

function init()
    application.setName("[gengine-tests] 90-labyr")
    application.setExtent(640,480)
end

function start()
    graphics.setClearColor(0.6,0.6,0.6,1)

    Game:load()

    Game:start(4,4,32)
end

function update(dt)
    Game:update(dt)
end
