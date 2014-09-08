dofile("component_placer.lua")
dofile("component_tile.lua")
dofile("tiles.lua")

Grid = Grid or {
    tiles = {}
}

function Grid:init(w, h, tileSize)
    self.width = w
    self.height = h
    self.tileSize = tileSize

    self.origin = {
        tileSize * ( w - 1 ) * -0.5,
        tileSize * ( h - 1 ) * -0.5
        }

    self:initPlacers()
end

function Grid:getTilePosition(i, j)
    local origin = self.origin

    return origin[1] + i * self.tileSize, origin[2] + j * self.tileSize
end

function Grid:fill()
    for i=0,self.width - 1 do
        for j=0,self.height - 1 do
            local e
            local tile = Tiles[math.random(1,#Tiles)]
            local rotation_index = math.random(0, 3)
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
                    originalValidDirections = tile.validDirections,
                },
                "tile"
                )

            e.rotation = - 3.141592/2 * rotation_index

            self:setTile(i, j, e)

            e:insert()
        end
    end
end

function Grid:setTile(i, j, e)
    if self.tiles[i] == nil then
        self.tiles[i] = {}
    end

    self.tiles[i][j] = e

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
    local result_map = {}

    for _, v in ipairs(contour) do
        contour_map[v] = true
    end

    for j=0,self.height - 1 do
        local contour_found = 0
        local last_was_contour = false
        for i=0,self.width - 1 do
            local tile = self:getTile(i, j)

            if contour_map[tile] then
                if not last_was_contour then
                    contour_found = contour_found + 1
                end

                last_was_contour = true
            else
                if contour_found % 2 == 1 then
                    result_map[tile] = true
                end
                last_was_contour = false
            end
        end
    end

    return result
end

function Grid:processContour(contour)
    local surrounded_tiles = self:getSurroundedTiles(contour)

    for _, v in ipairs(contour) do
        v.sprite.color = {x=0,y=0,z=1,w=1}
    end

    for _, v in ipairs(surrounded_tiles) do
        v.sprite.color = {x=0,y=1,z=0,w=1}
    end
end