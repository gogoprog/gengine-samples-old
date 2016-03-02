function init()
    gengine.application.setName("[gengine-samples] 01-animated_sprite_2d")
    gengine.application.setExtent(640, 480)
    gengine.application.setFullscreen(false)
end

local player1, player2

function start()
    gengine.graphics.setClearColor(Color(0,0,0.1));

    player1 = gengine.entity.create()

    player1:addComponent(
        ComponentAnimatedSprite2D(),
        {
            animationSet = cache:GetResource("AnimationSet2D", "spriter/player.scml"),
            animation = "walk",
            layer = 0
        },
        "sprite"
        )

    player1.position.x = -200
    player1.position.y = -200
    player1:insert()

    player2 = gengine.entity.create()

    player2:addComponent(
        ComponentAnimatedSprite2D(),
        {
            animationSet = cache:GetResource("AnimationSet2D", "spine/spineboy.json"),
            animation = "walk",
            layer = 0
        },
        "sprite"
        )

    player2.scale = Vector3(-0.5, 0.5, 1)
    player2.position.y = -200
    player2.position.x = 200
    player2:insert()

end

function update(dt)
    if gengine.input.isKeyDown(30) then
        player1.sprite.animation = "crouch_down"
        player2.sprite.animation = "shoot"
    end

    if gengine.input.isKeyDown(31) then
        player1.sprite.animation = "stand_up"
        player2.sprite.animation = "run"
    end

    if gengine.input.isKeyDown(32) then
        player1.sprite.animation = "crouch_idle"
        player2.sprite.animation = "jump"
    end

    if gengine.input.isKeyDown(33) then
        player1.sprite.animation = "jump_start"
        player2.sprite.animation = "death"
    end

    if gengine.input.isKeyDown(34) then
        player1.sprite.animation = "fall_start"
        player2.sprite.animation = "idle"
    end

    if gengine.input.isKeyDown(41) then
        gengine.application.quit()
    end
end

function stop()
end
