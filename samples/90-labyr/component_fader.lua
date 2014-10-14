ComponentFader = {}

gengine.stateMachine(ComponentFader)

function ComponentFader:init()
    self:changeState("idle")
end

function ComponentFader:insert()
    if self.autoStart then
        self:start()
    end
end

function ComponentFader:update(dt)
    self:updateState(dt)
end

function ComponentFader:remove()
end

function ComponentFader.onStateEnter:waiting()
    local sprite = self.entity.sprite
    sprite.alpha = 0
    self.time = 0
end

function ComponentFader.onStateUpdate:waiting(dt)
    self.time = self.time + dt

    if self.time > self.delay then
        self:changeState("appearing")
    end
end

function ComponentFader.onStateExit:waiting()

end

function ComponentFader.onStateEnter:appearing()
    self.time = 0
end

function ComponentFader.onStateUpdate:appearing(dt)
    local sprite = self.entity.sprite

    self.time = self.time + dt

    sprite.alpha = self.time / self.duration

    if self.time >= self.duration then
        self:changeState("idle")
    end
end

function ComponentFader.onStateExit:appearing()
    local sprite = self.entity.sprite
    sprite.alpha = 1
end

function ComponentFader.onStateUpdate:idle(dt)
end

function ComponentFader:start()
    self:changeState("waiting")
end
