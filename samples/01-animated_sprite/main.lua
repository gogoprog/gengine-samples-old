function init()
    gengine.application.setName("[gengine-tests] 01-animated_sprite")
    gengine.application.setExtent(320,200)
end

local characterEntity
local leftAnimation, rightAnimation, loopingAnimation

function start()
    gengine.graphics.setClearColor(0,0.1,0.1,1)

    local texture = gengine.graphics.texture.create("man.png")

    local atlas = gengine.graphics.atlas.create("test", texture, 12, 8)

    loopingAnimation = gengine.graphics.animation.create(
        "looping_animation",
        {
            atlas = atlas,
            frames = { 0, 1, 2, 1 },
            framerate = 5,
            loop = true
        }
        )

    leftAnimation = gengine.graphics.animation.create(
        "left",
        {
            atlas = atlas,
            frames = { 12, 13, 14, 13 },
            framerate = 5,
            loop = false
        }
        )

    rightAnimation = gengine.graphics.animation.create(
        "right",
        {
            atlas = atlas,
            frames = { 24, 25, 26, 25 },
            framerate = 5,
            loop = false
        }
        )

    characterEntity = gengine.entity.create()

    characterEntity:addComponent(
        ComponentAnimatedSprite(),
        {
            animation = loopingAnimation,
            extent = vector2(128, 128),
            layer = 0
        },
        "animatedSprite"
        )

    characterEntity:insert()
end

function update(dt)
    if gengine.input.keyboard:isJustUp(80) then -- left arrow
        characterEntity.animatedSprite:pushAnimation(leftAnimation)
    end

    if gengine.input.keyboard:isJustUp(79) then -- right arrow
        characterEntity.animatedSprite:pushAnimation(rightAnimation)
    end

    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()

end
