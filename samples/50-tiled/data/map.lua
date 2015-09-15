return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.13.0",
  orientation = "orthogonal",
  width = 12,
  height = 12,
  tilewidth = 32,
  tileheight = 32,
  nextobjectid = 9,
  properties = {},
  tilesets = {
    {
      name = "crates",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "crates.png",
      imagewidth = 160,
      imageheight = 64,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 10,
      tiles = {
        {
          id = 4,
          properties = {
            ["component"] = "Sprite,Physic"
          }
        },
        {
          id = 6,
          properties = {
            ["type"] = "XBox"
          }
        }
      }
    },
    {
      name = "crates_red",
      firstgid = 11,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "crates2.png",
      imagewidth = 160,
      imageheight = 64,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 10,
      tiles = {
        {
          id = 6,
          properties = {
            ["type"] = "XBoxRed"
          }
        }
      }
    },
    {
      name = "collection",
      firstgid = 21,
      tilewidth = 128,
      tileheight = 128,
      spacing = 0,
      margin = 0,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 1,
      tiles = {
        {
          id = 0,
          image = "bigcrate.png",
          width = 128,
          height = 128
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Tile Layer 1",
      x = 0,
      y = 0,
      width = 12,
      height = 12,
      visible = true,
      opacity = 1,
      properties = {
        ["component"] = "Sprite,Box",
        ["dummy"] = "Hello"
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 6,
        1, 0, 0, 17, 0, 21, 0, 0, 0, 1, 1, 6,
        6, 0, 0, 7, 0, 0, 0, 0, 8, 8, 8, 6
      }
    },
    {
      type = "tilelayer",
      name = "Tile Layer 2",
      x = 0,
      y = 0,
      width = 12,
      height = 12,
      visible = true,
      opacity = 1,
      properties = {
        ["component"] = "Sprite"
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 18, 18, 18, 18, 0, 0
      }
    },
    {
      type = "tilelayer",
      name = "Tile Layer 3",
      x = 0,
      y = 0,
      width = 12,
      height = 12,
      visible = true,
      opacity = 1,
      properties = {
        ["component"] = "Sprite,Physic",
        ["type"] = "dynamic"
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      name = "Tile Layer 4",
      x = 0,
      y = 0,
      width = 12,
      height = 12,
      visible = true,
      opacity = 1,
      properties = {
        ["component"] = "Sprite,Physic",
        ["type"] = "static"
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8
      }
    },
    {
      type = "objectgroup",
      name = "Object Layer 1",
      visible = true,
      opacity = 1,
      properties = {
        ["function"] = "createObject"
      },
      objects = {
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 280,
          y = -10,
          width = 41,
          height = 28,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "ellipse",
          x = 37,
          y = 69,
          width = 20,
          height = 21,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
