ComponentGround = {}

gengine.stateMachine(ComponentGround)

function ComponentGround:init()
end

function ComponentGround:insert()
    self:changeState("appearing")
end

function ComponentGround:update(dt)
    self:updateState(dt)
end

function ComponentGround:remove()
end

function ComponentGround.onStateEnter:appearing()
    local sprite = self.entity.sprite
    sprite.alpha = 0
    self.appearingTime = 0
end

function ComponentGround.onStateUpdate:appearing(dt)
    local sprite = self.entity.sprite

    self.appearingTime = self.appearingTime + dt

    sprite.alpha = self.appearingTime / self.appearingDuration

    if self.appearingTime >= self.appearingDuration then
        self:changeState("idle")
    end
end

function ComponentGround.onStateExit:appearing()
    local sprite = self.entity.sprite
    sprite.alpha = 1
end

function ComponentGround.onStateUpdate:idle(dt)

end