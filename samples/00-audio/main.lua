function init()
    gengine.application.setName("[gengine-tests] 00-audio")
    gengine.application.setExtent(320,200)
end

function start()
    gengine.graphics.setClearColor(0.5,0.1,0.1,1)

    gengine.audio.playMusic("test03.mp3") -- Play a background music.

    gengine.audio.sound.create("sound.ogg") -- Load a sound file.
end

function update(dt)
    if gengine.input.mouse:isJustDown(1) then
        gengine.audio.playSound(gengine.audio.sound.get("sound")) -- Play a previously loaded sound.
    end
    if gengine.input.keyboard:isJustUp(27) then
        gengine.application.quit()
    end
end

function stop()
end
