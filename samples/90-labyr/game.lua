dofile("grid.lua")

Game = Game or {}

function Game:load()
    for i=0,2 do
        gengine.graphics.texture.create("data/tile" .. i .. ".png")
    end
    gengine.graphics.texture.create("data/key.png")
end

function Game:start(w, h, ts, keys)
    self.score = 0
    self.keyLeft = 0
    Grid:init(w, h, ts)
    Grid:fill(keys)
    Grid:changeState("idling")

    self:pickNextPiece()
end

function Game:update(dt)
    Grid:update(dt)
end

function Game:moveTiles(i, j, d)
    self:increaseScore(1)
    if Grid:moveTiles(i, j, d, Grid:createTile(self.nextPiece, self.nextRotation)) then
        self:pickNextPiece()
    end
end

function Game:pickNextPiece()
    self.nextPiece = math.random(2,#Tiles)
    self.nextRotation = math.random(0, 3)
    Grid:updatePlacers()
end

function Game:increaseScore(value)
    self.score = self.score + value
    gengine.gui.executeScript("updateScore(" .. self.score .. ");")
end

function Game:onKeyFound()
    if self.keyLeft == 0 then
        print("Game completed!")
    end
end