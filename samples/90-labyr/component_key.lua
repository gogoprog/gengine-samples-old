ComponentKey = {}

function ComponentKey:init()
end

function ComponentKey:insert()
    Game.keyLeft = Game.keyLeft + 1
end

function ComponentKey:update(dt)
end

function ComponentKey:remove()
    Game.keyLeft = Game.keyLeft - 1
    Game:onKeyFound()
end

function ComponentKey:onMouseEnter()
    local sprite = self.entity.sprite
    sprite.color = {x=1,y=1,z=0,w=1}
end

function ComponentKey:onMouseExit()
    local sprite = self.entity.sprite
    sprite.color = {x=1,y=1,z=1,w=1}
end

function ComponentKey:onMouseJustDown()
    print("This is the key.")
end