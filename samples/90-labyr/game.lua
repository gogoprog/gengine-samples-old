dofile("grid.lua")
dofile("component_fader.lua")

Game = Game or {}

gengine.stateMachine(Game)

local x_offset = 120

function Game:load()
    for i=0,2 do
        gengine.graphics.texture.create("data/tile" .. i .. ".png")
    end

    for i=0,7 do
        gengine.graphics.texture.create("data/key" .. i .. ".png")
    end

    gengine.graphics.texture.create("data/pyramid.png")
    gengine.graphics.texture.create("data/ground.png")
    gengine.graphics.texture.create("data/outtile.png")
    gengine.graphics.texture.create("data/outarrow.png")

    self:changeState("idling")

    self:reset()

    local e
    e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("pyramid"),
            extent = { x=512, y=512 },
            layer = -2
        }
        )

    self.pyramid = e
    self.pyramid.position.x = x_offset

    e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("ground"),
            extent = { x=10, y=10 },
            layer = -1
        },
        "sprite"
        )

    e:addComponent(ComponentFader(), {
            delay = 2,
            duration = 1,
            autoStart = true
        })

    self.ground = e
    self.ground.position.x = x_offset
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
    Grid:init(w, h, ts, x_offset)
    Grid:fill(keys)
    Grid:changeState("idling")

    local s = (w+2) * ts
    self.ground.sprite.extent = { x=s, y=s }

    self:changeState("playing")
    self:pickRandomPiece()

    gengine.gui.loadFile("gui/hud.html")
    self.pyramid:insert()
    self.ground:insert()
end

function Game:update(dt)
    self:updateState(dt)
end

function Game:moveTiles(i, j, d)
    if self.state ~= "playing" or Grid.movingTiles ~= 0 then
      return
    end
    self:increaseScore(1)

    --local ntile = Grid:createTile(self.nextPiece, self.nextRotation)

    if Grid:moveTiles(i, j, d, self.nextTile) then

    else
        --gengine.entity.destroy(ntile)
    end
end

function Game:pickRandomPiece()
    self.nextPiece = math.random(2,#Tiles)
    self.nextRotation = math.random(0, 3)

    self.nextTile = Grid:createTile(self.nextPiece, self.nextRotation)
end

function Game:setNextTile(tile)
    self.nextPiece = tile.tile.tileIndex
    self.nextRotation = tile.tile.rotation
    self.nextTile = tile
    Grid:updatePlacers()
    self:changeState("collecting")
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
end

function Game.onStateUpdate:playing()
    Grid:update(dt)
end

function Game.onStateExit:playing()

end

function Game.onStateEnter:levelCompleted()
    self.pyramid:remove()
    self.ground:remove()
    gengine.gui.loadFile("gui/level_completed.html")
end

function Game.onStateUpdate:levelCompleted()

end

function Game.onStateEnter:collecting()
end

function Game.onStateUpdate:collecting()
    if self.nextTile.state ~= "collecting" then
        self:changeState("playing")
    end
end

function Game.onStateExit:collecting()
end