
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
    sprite.color = {x=0,y=1,z=0,w=1}
    local tile = Tiles[Game.nextPiece]
    sprite.texture = gengine.graphics.texture.get(tile.file)
    self.entity.rotation = - 3.141592/2 * Game.nextRotation
end

function ComponentPlacer:onMouseExit()
    local sprite = self.entity.sprite
    sprite.color = {x=1,y=1,z=1,w=1}
    local tile = Tiles[1]
    sprite.texture = gengine.graphics.texture.get(tile.file)
end

function ComponentPlacer:onMouseJustDown()
    self.entity.sprite.color = {x=1,y=0,z=0,w=1}

    Game:moveTiles(self.col, self.row, self.sens)
end