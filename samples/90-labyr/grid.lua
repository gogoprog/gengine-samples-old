dofile("component_placer.lua")
dofile("component_tile.lua")
dofile("component_key.lua")
dofile("component_fader.lua")
dofile("tiles.lua")

Grid = Grid or {
    tiles = {},
    placers = {}
}

gengine.stateMachine(Grid)

function Grid:reset()
    self.tilesToTest = {}
    self.tilesToCollect = {}

    for _, v in pairs(self.tiles) do
        for k, t in pairs(v) do
            if t then
                t:remove()
                gengine.entity.destroy(t)
            end
        end
    end

    self.tiles = {}

    for k, v in ipairs(self.placers) do
        v:remove()
        gengine.entity.destroy(v)
    end

    self.placers = {}
end

function Grid:init(w, h, tileSize, _x)
    self:reset()
    self.offset = { x=_x, y=0 }
    self.width = w
    self.height = h
    self.tileSize = tileSize

    self.origin = {
        tileSize * ( w - 1 ) * -0.5 + self.offset.x,
        tileSize * ( h - 1 ) * -0.5 + self.offset.y
        }

    self.movingTiles = 0
    self.rotatingTiles = 0

    self:initPlacers()
end

function Grid:getTilePosition(i, j)
    local origin = self.origin

    return origin[1] + i * self.tileSize, origin[2] + j * self.tileSize
end

function Grid:createTile(index, rot)
    local e
    local tile = Tiles[index]
    local rotation_index = rot
    e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get(tile.file),
            extent = { x=self.tileSize, y=self.tileSize },
            layer = 0
        },
        "sprite"
        )

    e:addComponent(
        ComponentMouseable(),
        {
            extent = { x=self.tileSize, y=self.tileSize }
        }
        )

    e:addComponent(
        ComponentTile(),
        {
            rotation = rotation_index,
            tile = tile,
            tileIndex = index,
        },
        "tile"
        )

    e:addComponent(
        ComponentFader(),
        {
            duration = 1,
            delay = 2
        },
        "fader"
        )


    e.rotation = - 3.141592/2 * rotation_index

    return e
end

function Grid:fill(keys)
    for i=0,self.width - 1 do
        for j=0,self.height - 1 do
            local e = self:createTile(math.random(1,#Tiles), math.random(0, 3))
            self:setTile(i, j, e)
            e.fader:start()
        end
    end

    local tiles = self.tiles
    local i, j
    local n = 0

    while keys > 0 do
        i = math.random(0, self.width - 1)
        j = math.random(0, self.height - 1)

        if not tiles[i][j].key then
            local e = tiles[i][j]
            e:addComponent(
                ComponentSprite(),
                {
                    texture = gengine.graphics.texture.get("key" ..(n%8) ),
                    extent = { x=self.tileSize, y=self.tileSize },
                    layer = 1
                },
                "keysprite"
                )

            e:addComponent(
                ComponentKey(),
                {
                },
                "key"
                )

            keys = keys - 1
            n = n + 1
        end
    end

    for i=0,self.width - 1 do
        for j=0,self.height - 1 do
            tiles[i][j]:insert()
        end
    end
end

function Grid:setTile(i, j, e)
    if i >= 0 and i < self.width and j >= 0 and j < self.height then
        if self.tiles[i] == nil then
            self.tiles[i] = {}
        end

        self.tiles[i][j] = e
    end

    local x, y = self:getTilePosition(i, j)

    e.position.x = x
    e.position.y = y

    e.tile.col = i
    e.tile.row = j
end

function Grid:getTile(i, j)
    if self.tiles[i] == nil then
        return nil
    end

    return self.tiles[i][j]
end

function Grid:createPlacer(i, j, rot)
    local e
    e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("outarrow"),
            extent = { x=self.tileSize, y=self.tileSize },
            layer = 0
        },
        "sprite"
        )

    e:addComponent(
        ComponentPlacer(),
        {
            initialRotation = rot,
            appearingDuration = 1 + math.random() * 1
        },
        "placer"
        )
    
    e:addComponent(
        ComponentMouseable(),
        {
            extent = { x=self.tileSize, y=self.tileSize }
        }
        )

     e:addComponent(
        ComponentFader(),
        {
            duration = 1,
            delay = 2
        },
        "fader"
        )

    e:insert()

    local x, y = self:getTilePosition(i, j)

    e.position.x = x
    e.position.y = y
    e.rotation = - 3.141592/2 * rot

    e.fader:start()

    table.insert(self.placers, e)

    return e
end

function Grid:createCorner(i, j)
    local e
    e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("outtile"),
            extent = { x=self.tileSize, y=self.tileSize },
            layer = 0
        },
        "sprite"
        )

    e:insert()

    local x, y = self:getTilePosition(i, j)

    e.position.x = x
    e.position.y = y

    table.insert(self.placers, e)

    return e
end

function Grid:initPlacers()
    local w = self.width -1
    local h = self.height -1

    local i = -1
    for j=0,h do
        local e = self:createPlacer(i, j, 0)
        e.placer.row = j
        e.placer.sens = 1
    end

    i = w + 1
    for j=0,h do
        local e = self:createPlacer(i, j, 2)
        e.placer.row = j
        e.placer.sens = -1
    end

    local j = -1
    for i=0,w do
        local e = self:createPlacer(i, j, 3)
        e.placer.col = i
        e.placer.sens = 1
    end

    j = h + 1
    for i=0,w do
        local e = self:createPlacer(i, j, 1)
        e.placer.col = i
        e.placer.sens = -1
    end

    self:createCorner(-1,-1)
    self:createCorner(-1, self.height)
    self:createCorner(self.width, self.height)
    self:createCorner(self.width, -1)
end

function Grid:updatePlacers()
    for k, v in ipairs(self.placers) do
        if v.placer and v.placer.itIsHighlighted then
            v.placer:onMouseEnter()
        end
    end
end

function Grid:moveTiles(i, j, d, ntile)
    local w = self.width -1
    local h = self.height -1

    if not i then
        if d > 0 then
            if self.tiles[w][j].key then
                return false
            end
            self:setTile(-1,j,ntile)
            ntile.tile:moveTo(0,j)
        else
            if self.tiles[0][j].key then
                return false
            end
            self:setTile(w + 1,j,ntile)
            ntile.tile:moveTo(w,j)
        end

        for i=0,w do
            self.tiles[i][j].tile:moveTo(i+d,j)
            self.movingTiles = self.movingTiles + 1
        end

        ntile:insert()
        self.movingTiles = self.movingTiles + 1
    elseif not j then
        if d > 0 then
            if self.tiles[i][h].key then
                return false
            end
            self:setTile(i,-1,ntile)
            ntile.tile:moveTo(i,0)
        else
            if self.tiles[i][0].key then
                return false
            end
            self:setTile(i,h+1,ntile)
            ntile.tile:moveTo(i,h)
        end

        for j=0,h do
            self.tiles[i][j].tile:moveTo(i,j+d)
            self.movingTiles = self.movingTiles + 1
        end

        ntile:insert()
        self.movingTiles = self.movingTiles + 1
    end

    return true
end

function Grid:onTileArrived(tile, i, j)
    local width = self.width
    local height = self.height
    if i >= 0 and i < width and j >= 0 and j < height then
        self:setTile(i, j, tile)
        self.movingTiles = self.movingTiles - 1
    else
        tile.tile.lastI = i
        tile.tile.lastJ = j
        table.insert(self.tilesToCollect, tile)
    end

    if self.movingTiles == 0 then
        for j=0,self.height - 1 do
            for i=0,self.width - 1 do
                table.insert(self.tilesToTest, self.tiles[i][j])
            end
        end
    end
end

Grid.getTileFromDir = {}

Grid.getTileFromDir[0] = function(self, e)
    return self:getTile(e.col, e.row + 1)
end

Grid.getTileFromDir[1] = function(self, e)
    return self:getTile(e.col + 1, e.row)
end

Grid.getTileFromDir[2] = function(self, e)
    return self:getTile(e.col, e.row - 1)
end

Grid.getTileFromDir[3] = function(self, e)
    return self:getTile(e.col - 1, e.row)
end

function Grid:testConnections(e, list)
    local tile = e.tile
    local c, r = tile.col, tile.row

    for i = 0,3 do
        if tile:canConnect(i) then
            local j = (i+2) % 4
            local other = self.getTileFromDir[i](Grid, tile)
            if other and other.tile:canConnect(j) then
                if #list >= 4 and other == list[1] then
                    self:processContour(list)
                    return
                elseif other ~= list[#list - 1] then
                    local new_list = {}
                    for _, v in ipairs(list) do
                        table.insert(new_list, v)
                    end
                    table.insert(new_list, other)
                    self:testConnections(other, new_list)
                end
            end
        end
    end
end

function Grid:getSurroundedTiles(contour)
    local result = {}
    local contour_map = {}

    for _, v in ipairs(contour) do
        contour_map[v] = true
    end

    for j=0,self.height - 1 do
        local contour_found = 0
        local corner_found = false
        local first_corner_dir = nil
        for i=0,self.width - 1 do
            local tile = self:getTile(i, j)

            if contour_map[tile] then
                if tile.tile:isCorner() then
                    if not corner_found then
                        if tile.tile:canConnect(0) then
                            first_corner_dir = 0
                        else
                            first_corner_dir = 2
                        end
                        corner_found = true
                    else
                        if not tile.tile:canConnect(first_corner_dir) then
                            contour_found = contour_found + 1
                        end

                        corner_found = false
                    end
                elseif tile.tile:isVertical() then
                    contour_found = contour_found + 1
                end
            else
                if contour_found % 2 == 1 then
                    table.insert(result, tile)
                end
            end
        end
    end

    return result
end

function Grid:processContour(contour)
    local surrounded_tiles = self:getSurroundedTiles(contour)

    for _, v in ipairs(contour) do
        v.tile:changeState("shaking")
    end

    for _, v in ipairs(surrounded_tiles) do
        v.tile:changeState("shaking")
    end
end

function Grid:addTileToTest(e)
    table.insert(self.tilesToTest, e)
end

function Grid:update(dt)
    self:updateState(dt)
end

function Grid.onStateUpdate:idling(dt)
    for k, v in ipairs(self.tilesToCollect) do
        v.tile:changeState("collecting")
        Game:setNextTile(v)
    end
    self.tilesToCollect = {}

    if self.rotatingTiles > 0 or self.movingTiles > 0 then
        return
    end

    for k, v in ipairs(self.tilesToTest) do
        self:testConnections(v, {v})
    end
    self.tilesToTest = {}
end
