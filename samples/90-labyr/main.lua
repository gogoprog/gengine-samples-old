dofile("game.lua")

function init()
    --debug = require("debug")
    --require("mobdebug").start()
    gengine.application.setName("[gengine-tests] 90-labyr")
    gengine.application.setExtent(640,480)
end

local logoEntity

local game = Game()

function start()
    gengine.graphics.setClearColor(0.6,0.6,1,1)

    game:load()
end

function update(dt)
    game:update(dt)
end
