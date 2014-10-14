ComponentKey = {}

gengine.stateMachine(ComponentKey)

function ComponentKey:init()
    self.time = 0
end

function ComponentKey:insert()
    Game.keyLeft = Game.keyLeft + 1
    self:changeState("appearing")
end

function ComponentKey:update(dt)
    self:updateState(dt)
end

function ComponentKey:remove()
    Game.keyLeft = Game.keyLeft - 1
    Game:onKeyFound()
end

function ComponentKey.onStateEnter:appearing()
    local sprite = self.entity.keysprite
    sprite.alpha = 0
    self.appearingTime = 0
    self.appearingDuration = 5
end

function ComponentKey.onStateUpdate:appearing(dt)
    local sprite = self.entity.keysprite

    self.appearingTime = self.appearingTime + dt

    local at = self.appearingTime

    sprite.alpha = at / self.appearingDuration

    local e = 32 + 16 * math.cos(at * 6)

    sprite.extent = {x=e, y=e}

    if self.appearingTime >= self.appearingDuration then
        self:changeState("idle")
    end
end

function ComponentKey.onStateExit:appearing()
    local sprite = self.entity.keysprite
    sprite.alpha = 1
    sprite.extent = {x=32, y=32}
end
