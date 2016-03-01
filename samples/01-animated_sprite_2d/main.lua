function init()
    gengine.application.setName("[gengine-samples] 01-sprite")
    gengine.application.setExtent(640, 480)
    gengine.application.setFullscreen(false)
end

local player

function start()
    gengine.graphics.setClearColor(Color(0,0,0.1));

    local e = gengine.entity.create()

    e:addComponent(
        ComponentAnimatedSprite2D(),
        {
            --animationSet = cache:GetResource("AnimationSet2D", "spriter/player.scml"),
            animationSet = cache:GetResource("AnimationSet2D", "spine/spineboy.json"),
            animation = "walk",
            layer = 0
        },
        "sprite"
        )

    e.position.y = -200
    e:insert()

    player = e
end

function update(dt)
    if gengine.input.isKeyDown(30) then
        player.sprite.animation = "crouch_down"
    end

    if gengine.input.isKeyDown(31) then
        player.sprite.animation = "stand_up"
    end

    if gengine.input.isKeyDown(32) then
        player.sprite.animation = "crouch_idle"
    end

    if gengine.input.isKeyDown(33) then
        player.sprite.animation = "jump_start"
    end

    if gengine.input.isKeyDown(34) then
        player.sprite.animation = "fall_start"
    end

    if gengine.input.isKeyDown(41) then
        gengine.application.quit()
    end
end

function stop()
end
