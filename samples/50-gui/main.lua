function init()
    application.setName("[gengine-tests] 50-gui")
    application.setExtent(800,600)
end

local logoEntity

function start()
    graphics.setClearColor(0,0.1,0.1,1)

    graphics.texture.create("logo.png")

    logoEntity = entity.create()

    logoEntity:addComponent(
        ComponentSprite(),
        {
            texture = graphics.texture.get("logo"),
            extent = { x=2560, y=1280 },
            layer = 0
        }
        )

    logoEntity:insert()

    gui.loadFile("gui/menu.html")
end

local total = 0
local sens = 1

function update(dt)
    total = total + dt * sens
    logoEntity.rotation = total

    if input.mouse:isJustDown(1) then
        gui.executeScript("updateTotal('" .. total .. "');")
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
