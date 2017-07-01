return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.18.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 10,
  height = 10,
  tilewidth = 16,
  tileheight = 16,
  nextobjectid = 4,
  properties = {},
  tilesets = {
    {
      name = "basic tileset",
      firstgid = 1,
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      image = "../gra/basictiles.png",
      imagewidth = 256,
      imageheight = 192,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 192,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "ground",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        119, 119, 119, 119, 119, 119, 119, 119, 119, 119,
        119, 119, 119, 119, 119, 119, 119, 119, 119, 119,
        119, 119, 119, 119, 119, 119, 119, 119, 119, 119,
        119, 119, 119, 119, 119, 119, 119, 119, 119, 119,
        119, 119, 119, 119, 119, 119, 119, 119, 119, 119,
        119, 119, 119, 119, 119, 119, 119, 119, 119, 119,
        119, 119, 119, 119, 119, 119, 119, 119, 119, 119,
        119, 119, 119, 119, 119, 119, 119, 119, 119, 119,
        119, 119, 119, 119, 119, 119, 119, 119, 119, 119,
        119, 119, 119, 119, 119, 119, 119, 119, 119, 119
      }
    },
    {
      type = "tilelayer",
      name = "road",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 122, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      name = "tile",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["collidable"] = true
      },
      encoding = "lua",
      data = {
        3221225592, 3221225592, 3221225592, 3221225592, 3221225592, 3221225592, 3221225592, 3221225592, 3221225592, 3221225592,
        104, 0, 0, 0, 0, 0, 0, 0, 0, 104,
        104, 0, 0, 0, 0, 0, 0, 0, 0, 104,
        104, 0, 0, 0, 0, 0, 0, 0, 0, 104,
        104, 0, 0, 0, 0, 0, 0, 0, 0, 104,
        104, 0, 0, 0, 0, 13, 15, 15, 15, 104,
        104, 0, 0, 0, 0, 0, 0, 0, 0, 104,
        104, 0, 0, 0, 0, 14, 0, 0, 0, 104,
        104, 0, 0, 0, 0, 13, 13, 13, 13, 104,
        120, 120, 120, 120, 120, 120, 120, 120, 120, 120
      }
    },
    {
      type = "objectgroup",
      name = "mob",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 3,
          name = "player",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 16,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["imgx"] = 2,
            ["imgy"] = 1
          }
        }
      }
    },
    {
      type = "objectgroup",
      name = "interactive",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 1,
          name = "stairs up",
          type = "teleporter",
          shape = "rectangle",
          x = 16,
          y = 16,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["destination"] = "level_1"
          }
        },
        {
          id = 2,
          name = "chest1",
          type = "chest",
          shape = "rectangle",
          x = 128,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
