function init()
    gengine.application.setName("[gengine-samples] 50-gui")
    gengine.application.setExtent(800,600)
end

local logoEntity

function start()
    gengine.graphics.setClearColor(Color(0,0.1,0.1,1))

    logoEntity = gengine.entity.create()

    logoEntity:addComponent(
        ComponentStaticSprite2D(),
        {
            sprite = cache:GetResource('Sprite2D', 'logo.png'),
            layer = 0
        }
        )

    logoEntity:insert()

    gengine.gui.loadFile("gui/gui.html")
end

local total = 0
local sens = 1

function update(dt)
    total = total + dt * sens * 100
    logoEntity.rotation = total

    if gengine.gui.state == "options" then
        gengine.gui.executeScript("updateTotal('" .. total .. "');")
    end

    if gengine.input.isKeyJustDown(41) then
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
