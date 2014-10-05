dofile("grid.lua")

Game = Game or {}

gengine.stateMachine(Game)

function Game:load()
    for i=0,2 do
        gengine.graphics.texture.create("data/tile" .. i .. ".png")
    end
    gengine.graphics.texture.create("data/key.png")

    self:changeState("idling")

    self:reset()
end

function Game:reset()
    self.score = 0
end

function Game:playLevel(lvl)
    self:start(lvl+3, lvl+3, 32, lvl)
    self.currentLevel = lvl
end

function Game:playNextLevel()
    self:playLevel(self.currentLevel + 1)
end

function Game:start(w, h, ts, keys)
    self.score = 0
    self.keyLeft = 0
    Grid:init(w, h, ts)
    Grid:fill(keys)
    Grid:changeState("idling")

    self:changeState("playing")
    self:pickNextPiece()
end

function Game:update(dt)
    self:updateState(dt)
end

function Game:moveTiles(i, j, d)
    if self.state ~= "playing" or Grid.movingTiles ~= 0 then
      return
    end
    self:increaseScore(1)

    local ntile = Grid:createTile(self.nextPiece, self.nextRotation)

    if Grid:moveTiles(i, j, d, ntile) then
        self:pickNextPiece()
    else
        gengine.entity.destroy(ntile)
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
        self:changeState("levelCompleted")
    end
end

function Game.onStateUpdate:idling()

end

function Game.onStateEnter:playing()
    gengine.gui.loadFile("gui/hud.html")
end

function Game.onStateUpdate:playing()
    Grid:update(dt)
end

function Game.onStateEnter:levelCompleted()
    gengine.gui.loadFile("gui/level_completed.html")
end

function Game.onStateUpdate:levelCompleted()

end
