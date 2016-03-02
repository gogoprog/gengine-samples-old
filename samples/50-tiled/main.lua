ComponentBox = {}

function ComponentBox:init()
end

function ComponentBox:insert()
    print("Box with type " .. (self.type or "(none)"))
end

function ComponentBox:update(dt)
end

function ComponentBox:remove()
end

function createObject(o)
    print("Object at " .. o.x .. ", " .. o.y)
end

function init()
    gengine.application.setName("[gengine-samples] 50-tiled")
    gengine.application.setExtent(800,600)
end

function start()
    gengine.graphics.setClearColor(Color(0.5,0.5,0.5,1))

    local e

    e = gengine.entity.create()

    e:addComponent(
        ComponentTileMap2D(),
        {
            --tmxFile = cache:GetResource("TmxFile2D", "isometric_grass_and_water.tmx")
            tmxFile = cache:GetResource("TmxFile2D", "map.tmx")
        },
        "tileMap"
        )

    e.position.x = -192
    e.position.y = -192
    e:insert()

    for l=0, e.tileMap.numLayers-1 do
        local layer = e.tileMap:GetLayer(l)
        for x=0,layer.width - 1 do
            for y=0,layer.height - 1 do
                local tile = layer:GetTile(x, y)

                if tile then
                    if tile:HasProperty("physic") or layer:HasProperty("physic") then
                        print(":TODO:")
                    end
                end
            end
        end
    end
end

function update(dt)
    if gengine.input.isKeyJustDown(41) then
        gengine.application.quit()
    end
end

function stop()

end
