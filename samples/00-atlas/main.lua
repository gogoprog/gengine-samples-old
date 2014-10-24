function init()
    gengine.application.setName("[gengine-tests] 01-sprite")
    gengine.application.setExtent(320,200)
end

local logoEntity

function start()
    gengine.graphics.setClearColor(0,0.1,0.1,1)

    local texture = gengine.graphics.texture.create("logo.png")

    gengine.graphics.atlas.create("test", texture, 5, 1)

    logoEntity = gengine.entity.create()

    logoEntity:addComponent(
        ComponentSprite(),
        {
            atlas = gengine.graphics.atlas.get("test"),
            atlasItem = 4,
            extent = vector2(256, 128),
            layer = 0
        }
        )

    logoEntity:insert()
end

function update(dt)

end
