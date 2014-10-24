function init()
    gengine.application.setName("[gengine-tests] 01-animated_sprite")
    gengine.application.setExtent(320,200)
end

local logoEntity

function start()
    gengine.graphics.setClearColor(0,0.1,0.1,1)

    local texture = gengine.graphics.texture.create("man.png")

    local atlas = gengine.graphics.atlas.create("test", texture, 12, 8)

    local animation = gengine.graphics.animation.create("testa",
        {
            atlas = atlas,
            frames = { 0, 1, 2, 1 },
            framerate = 5
        }
        )

    logoEntity = gengine.entity.create()

    logoEntity:addComponent(
        ComponentAnimatedSprite(),
        {
            animation = animation,
            extent =vector2(128, 128),
            layer = 0
        }
        )

    logoEntity:insert()
end

function update(dt)
    if gengine.input.keyboard:isJustUp(27) then
        gengine.application.quit()
    end
end

function stop()

end
