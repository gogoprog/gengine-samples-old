dofile("grid.lua")

Game = Game or {}

function Game:load()
    for i=0,2 do
        graphics.texture.create("data/tile" .. i .. ".png")
    end
end

function Game:start(w, h, ts)
    Grid:init(w, h, ts)
    Grid:fill()
end

function Game:update(dt)

end
