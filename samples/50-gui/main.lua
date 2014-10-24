function init()
    gengine.application.setName("[gengine-tests] 50-gengine.gui")
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
            extent = vector2(2560, 1280),
            layer = 0
        }
        )

    logoEntity:insert()

    gengine.gui.loadFile("gui/menu.html")
end

local total = 0
local sens = 1

function update(dt)
    total = total + dt * sens
    logoEntity.rotation = total

    if gengine.input.mouse:isJustDown(1) then
        gengine.gui.executeScript("updateTotal('" .. total .. "');")
    end
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
    print("exit() called!")
end
