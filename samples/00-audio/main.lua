function init()
    gengine.application.setName("[gengine-tests] 00-gengine.audio")
    gengine.application.setExtent(320,200)
end

function start()
    gengine.graphics.setClearColor(0.5,0.1,0.1,1)

    gengine.audio.playMusic("test03.mp3")
end

function update(dt)
end
