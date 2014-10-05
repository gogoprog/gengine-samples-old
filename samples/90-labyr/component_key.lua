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
