
IsometricMap = {
    cellSize = 32
}

function IsometricMap:init()
    local texture = gengine.graphics.texture.create("tile_set.png") -- Loading the sprite sheet.

    gengine.graphics.atlas.create(
        "tile_set",
        texture,
        { 
            -- Grass
            vector4(0*64, 0*64, 64, 64),
            vector4(1*64, 0*64, 64, 64),
            vector4(2*64, 0*64, 64, 64),
            vector4(3*64, 0*64, 64, 64),
            vector4(4*64, 0*64, 64, 64),
        }
        )

    local entity = gengine.entity.create()

    entity:addComponent(
        ComponentSpriteBatch(),
        {
            atlas = gengine.graphics.atlas.get("tile_set"),
            size = 102400,
            layer = 0
        },
        "Batch"
        )

    local batch = entity.Batch

    batch:lock()

    -- Fill the screen with grass
    for j=-240, 2400, self.cellSize do
        for i=-320, 3200, self.cellSize do
            batch:addItem(math.random(0, 4), self:getIsoFromCar(i, j))
        end
    end

    batch:unlock()

    entity:insert()
end

function IsometricMap:getIsoFromCar(x, y)
    return vector2(x - y, (x + y) / 2)
end

function IsometricMap:getCarFromIso(i, j)
    return vector2((i + 2*j) /2, (2*j - i )/2)
end

local cameraEntity, lastMouseX, lastMouseY

function init()
    gengine.application.setName("[gengine-tests] 80-isometric")
    gengine.application.setExtent(1024,640)
end

function start()
    gengine.graphics.setClearColor(0,0.1,0.1,1)

    IsometricMap:init()

    cameraEntity = gengine.entity.create()
    cameraEntity:addComponent(
        ComponentCamera(),
        { 
            extent = vector2(1024, 640)
        },
        "camera"
        )
    cameraEntity:insert()
end


function update(dt)
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end

    local mx, my = gengine.input.mouse:getPosition()

    if gengine.input.mouse:isDown(1) then
        local dx, dy = lastMouseX - mx, lastMouseY - my

        cameraEntity.position.x = cameraEntity.position.x + dx
        cameraEntity.position.y = cameraEntity.position.y - dy
    end

    lastMouseX = mx
    lastMouseY = my
end

function stop()

end


