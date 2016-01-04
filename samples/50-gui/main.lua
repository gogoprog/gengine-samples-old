function init()
    gengine.application.setName("[gengine-samples] 50-gui")
    gengine.application.setExtent(800,600)
end

local logoEntity

function start()
    gengine.graphics.setClearColor(0,0.1,0.1,1)

    gengine.graphics.texture.create("logo.png")

    logoEntity = gengine.entity.create()

    logoEntity:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("logo"),
            extent = vector2(512, 256),
            layer = 0
        }
        )

    logoEntity:insert()

    gengine.gui.loadFile("gui/gui.html")
end

local total = 0
local sens = 1

function update(dt)
    total = total + dt * sens
    logoEntity.rotation = total

    if gengine.gui.state == "options" then
        gengine.gui.executeScript("updateTotal('" .. total .. "');")
    end

    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()

end

function newGame()
    print("newGame() called!")
    sens = 1
end

function options()
    print("options() called!")
    sens = -1
end

function exit()
    gengine.application.quit()
end

function gengine.gui.onStateEnter:main()
    print("Main menu")
end

function gengine.gui.onStateEnter:options()
    print("Options")
end
