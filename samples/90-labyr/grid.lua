dofile("component_placer.lua")
dofile("component_tile.lua")
dofile("component_key.lua")
dofile("tiles.lua")

Grid = Grid or {
    tiles = {},
    tilesToTest = {},
    placers = {}
}

gengine.stateMachine(Grid)

function Grid:reset()
    self.tilesToTest = {}

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

function Grid:init(w, h, tileSize)
    self:reset()

    self.width = w
    self.height = h
    self.tileSize = tileSize

    self.origin = {
        tileSize * ( w - 1 ) * -0.5,
        tileSize * ( h - 1 ) * -0.5
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
            tile = tile
        },
        "tile"
        )

    e.rotation = - 3.141592/2 * rotation_index

    return e
end

function Grid:fill(keys)
    for i=0,self.width - 1 do
        for j=0,self.height - 1 do
            local e = self:createTile(math.random(1,#Tiles), math.random(0, 3))
            self:setTile(i, j, e)
        end
    end

    local tiles = self.tiles
    local i, j

    while keys > 0 do
        i = math.random(0, self.width - 1)
        j = math.random(0, self.height - 1)

        if not tiles[i][j].key then
            local e = tiles[i][j]
            e:addComponent(
                ComponentSprite(),
                {
                    texture = gengine.graphics.texture.get("key"),
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

function Grid:createPlacer(i, j)
    local e
    e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("tile0"),
            extent = { x=self.tileSize, y=self.tileSize },
            layer = 0
        },
        "sprite"
        )

    e:addComponent(
        ComponentPlacer(),
        {
        },
        "placer"
        )
    
    e:addComponent(
        ComponentMouseable(),
        {
            extent = { x=self.tileSize, y=self.tileSize }
        }
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
        local e = self:createPlacer(i, j)
        e.placer.row = j
        e.placer.sens = 1
    end

    i = w + 1
    for j=0,h do
        local e = self:createPlacer(i, j)
        e.placer.row = j
        e.placer.sens = -1
    end

    local j = -1
    for i=0,w do
        local e = self:createPlacer(i, j)
        e.placer.col = i
        e.placer.sens = 1
    end

    j = h + 1
    for i=0,w do
        local e = self:createPlacer(i, j)
        e.placer.col = i
        e.placer.sens = -1
    end
end

function Grid:updatePlacers()
    for k, v in ipairs(self.placers) do
        if v.placer.itIsHighlighted then
            v.placer:onMouseEnter()
        end
    end
end

function Grid:moveTiles(i, j, d, ntile)
    if self.movingTiles > 0 then
        gengine.entity.destroy(ntile)
        return false
    end

    local w = self.width -1
    local h = self.height -1

    if not i then
        for i=0,w do
            if self.tiles[i] and self.tiles[i][j] then
                self.tiles[i][j].tile:moveTo(i+d,j)
                self.movingTiles = self.movingTiles + 1
            end
        end
        if d > 0 then
            self:setTile(-1,j,ntile)
            ntile.tile:moveTo(0,j)
        else
            self:setTile(w + 1,j,ntile)
            ntile.tile:moveTo(w,j)
        end
        ntile:insert()
        self.movingTiles = self.movingTiles + 1
    elseif not j then
        for j=0,h do
            if self.tiles[i] and self.tiles[i][j] then
                self.tiles[i][j].tile:moveTo(i,j+d)
                self.movingTiles = self.movingTiles + 1
            end
        end
        if d > 0 then
            self:setTile(i,-1,ntile)
            ntile.tile:moveTo(i,0)
        else
            self:setTile(i,h+1,ntile)
            ntile.tile:moveTo(i,h)
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
    else
        tile:remove()
        gengine.entity.destroy(tile)
    end

    self.movingTiles = self.movingTiles - 1

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
        v.sprite.color = {x=0,y=0,z=1,w=1}
        v.tile:changeState("shaking")
    end

    for _, v in ipairs(surrounded_tiles) do
        v.sprite.color = {x=0,y=1,z=0,w=1}
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
    if self.rotatingTiles > 0 or self.movingTiles > 0 then
        return
    end

    for k, v in ipairs(self.tilesToTest) do
        self:testConnections(v, {v})
    end
    self.tilesToTest = {}
end
