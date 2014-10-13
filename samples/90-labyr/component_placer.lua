ComponentPlacer = {}

function ComponentPlacer:init()
end

function ComponentPlacer:insert()
end

function ComponentPlacer:update(dt)
end

function ComponentPlacer:remove()
end

function ComponentPlacer:onMouseEnter()
    local sprite = self.entity.sprite
    sprite.color = {x=0.8, y=0.8, z=0.8,w=1}
    local tile = Tiles[Game.nextPiece]
    sprite.texture = gengine.graphics.texture.get(tile.file)
    self.entity.rotation = - 3.141592/2 * Game.nextRotation

    self.itIsHighlighted = true
end

function ComponentPlacer:onMouseExit()
    local sprite = self.entity.sprite
    sprite.color = {x=1,y=1,z=1,w=1}
    local tile = Tiles[1]

    sprite.texture = gengine.graphics.texture.get("outarrow")

    self.entity.rotation = - 3.141592/2 * self.initialRotation

    self.itIsHighlighted = false
end

function ComponentPlacer:onMouseJustDown()
    Game:moveTiles(self.col, self.row, self.sens)
end