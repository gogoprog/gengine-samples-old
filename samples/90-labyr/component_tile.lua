
ComponentTile = {}

gengine.stateMachine(ComponentTile)

function ComponentTile:init()
    self.moveDuration = 0.2
    self:changeState("none")
end

function ComponentTile:insert()
end

function ComponentTile:remove()
end

function ComponentTile:moveTo(i,j)
    if self.state == "none" then
        local tx, ty = Grid:getTilePosition(i ,j)

        self.targetPos = {
            x = tx,
            y = ty
            }

        self.target = { i, j }

        self.from = {
            x = self.entity.position.x,
            y = self.entity.position.y
            }

        self.time = 0
        self:changeState("moving")
    end
end

function ComponentTile:rotate()
    if self.state == "none" then
        self.fromRotation = self.entity.rotation
        self.time = 0
        self:changeState("rotating")
        self.rotation = self.rotation + 1
        if self.rotation < 0 then
            self.rotation = 3
        end

        self.rotation = self.rotation % 4

        self.toRotation = self.fromRotation - 3.141592/2
    end
end

function ComponentTile:onMouseEnter()
    if self.entity.fader.state == "idle" then
        local sprite = self.entity.sprite
        sprite.color = {x=0.8,y=0.8,z=0.8,w=1}
    end
end

function ComponentTile:onMouseExit()
    if self.entity.fader.state == "idle" then
        self.entity.sprite.color = {x=1,y=1,z=1,w=1}
    end
end

function ComponentTile:onMouseJustDown(b)
    if self.entity.fader.state == "idle" then
        if b == 1 then
            self:rotate()
        end
        
        -- debug
        if b == 2 then
            local tile = Tiles[math.random(1,#Tiles)]
            self.entity.sprite.texture = gengine.graphics.texture.get(tile.file)
            self.rotation = tile.rotation
            self.tile = tile
            self.entity.rotation = - 3.141592/2 * tile.rotation
        end
    end
end

function ComponentTile:update(dt)
    self:updateState(dt)
end

function ComponentTile.onStateUpdate:moving(dt)
    self.time = self.time + dt

    if self.time >= self.moveDuration then
        self.time = self.moveDuration
        self:changeState("none")
    end

    local p = self.entity.position
    local from = self.from
    local target = self.targetPos
    local f = self.time / self.moveDuration

    p.x = from.x + (target.x - from.x) * f
    p.y = from.y + (target.y - from.y) * f
end

function ComponentTile.onStateExit:moving()
    local i,j = self.target[1], self.target[2]
    Grid:onTileArrived(self.entity, i, j)
end

function ComponentTile.onStateEnter:rotating()
    Grid.rotatingTiles = Grid.rotatingTiles + 1
end

function ComponentTile.onStateUpdate:rotating(dt)
    self.time = self.time + dt

    if self.time >= self.moveDuration then
        self.time = self.moveDuration

        if self.entity.rotation < 0 then
            self.entity.rotation = self.entity.rotation + 3.141592 * 2
        end

        self:changeState("none")
    end

    local p = self.entity.position
    local from = self.fromRotation
    local target = self.toRotation
    local f = self.time / self.moveDuration

    self.entity.rotation = from + (target - from) * f
end

function ComponentTile.onStateExit:rotating()
    Grid.rotatingTiles = Grid.rotatingTiles - 1
    Grid:addTileToTest(self.entity)
end

function ComponentTile.onStateEnter:shaking()
    self.time = 0
    self.totalTime = 0
    local e = self.entity
    local p = e.position
    self.initialRotation = e.rotation
    self.initialPosition = {p.x, p.y}
end

function ComponentTile.onStateUpdate:shaking(dt)
    self.time = self.time + dt
    self.totalTime = self.totalTime + dt

    self.entity.sprite.color = {x=1.0,y=1.0,z=1.0,w=1-(self.totalTime/1)}

    if self.time > 0.1 then
        local e = self.entity
        local p = e.position
        local init_pos = self.initialPosition
        e.rotation = math.random() * 0.1 + self.initialRotation - 0.05
        p.x = init_pos[1] + math.random(-2,2)
        p.y = init_pos[2] + math.random(-2,2)
        self.time = 0

        if self.totalTime >= 1 then
            local tile = Tiles[1]
            e.sprite.texture = gengine.graphics.texture.get(tile.file)
            self.rotation = tile.rotation
            self.tile = tile
            self.entity.rotation = - 3.141592/2 * tile.rotation
            self:changeState("none")

            if self.entity.key then
                e.key:remove()
                e.keysprite:remove()
                e:removeComponent("key")
                e:removeComponent("keysprite")
            end
        end
    end
end

function ComponentTile.onStateExit:shaking()
    local e = self.entity
    local p = e.position
    local init_pos = self.initialPosition
    self.entity.rotation = self.initialRotation
    p.x = init_pos[1]
    p.y = init_pos[2]
    self.entity.sprite.color = {x=1.0,y=1.0,z=1.0,w=1}
end

function ComponentTile.onStateEnter:collecting()
    self.time = 0
    local e = self.entity
    local p = e.position
    self.initialPosition = {p.x, p.y}
    self.targetPostition = {-294, 135}
    self.moveDuration = 0.2
    self.entity.sprite.layer = 100
end

local function easeIneaseOut(p)
    return ( ( 1.0 - math.cos( ( p ) * math.pi ) ) * 0.5 )
end

function ComponentTile.onStateUpdate:collecting(dt)
    self.time = self.time + dt

    if self.time >= self.moveDuration then
        self.time = self.moveDuration
        self:changeState("none")
    end

    local p = self.entity.position
    local from = self.initialPosition
    local target = self.targetPostition
    local f = self.time / self.moveDuration

    p.x = from[1] + (target[1] - from[1]) * easeIneaseOut(f)
    p.y = from[2] + (target[2] - from[2]) * easeIneaseOut(f)
end

function ComponentTile.onStateExit:collecting()
    Grid.movingTiles = Grid.movingTiles - 1
end

function ComponentTile:canConnect(dir)
    local d = dir - self.rotation

    if d < 0 then d = d + 4 end

    return self.tile.validDirections[d + 1]
end

function ComponentTile:isCorner()
    return self.tile.corner
end

function ComponentTile:isVertical()
    return self:canConnect(0) and self:canConnect(2)
end
