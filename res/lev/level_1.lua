return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.18.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 20,
  height = 20,
  tilewidth = 16,
  tileheight = 16,
  nextobjectid = 73,
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
      terrains = {
        {
          name = "grass",
          tile = -1,
          properties = {}
        },
        {
          name = "forest",
          tile = -1,
          properties = {}
        }
      },
      tilecount = 192,
      tiles = {
        {
          id = 0,
          objectGroup = {
            type = "objectgroup",
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {}
          }
        },
        {
          id = 24,
          terrain = { 1, 1, 1, 1 }
        },
        {
          id = 25,
          terrain = { 1, 1, 1, 1 }
        },
        {
          id = 30,
          terrain = { 0, 0, 0, 0 }
        },
        {
          id = 31,
          terrain = { 0, 0, 0, 0 }
        },
        {
          id = 40,
          terrain = { 1, 1, 1, 1 }
        },
        {
          id = 46,
          terrain = { 0, 0, 0, 0 }
        },
        {
          id = 47,
          terrain = { 0, 0, 0, 0 }
        }
      }
    },
    {
      name = "collisions tileset",
      firstgid = 193,
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      image = "../gra/collisions.png",
      imagewidth = 64,
      imageheight = 64,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 16,
      tiles = {
        {
          id = 0,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 1,
          properties = {
            ["collidable"] = false
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "underwater",
      x = 0,
      y = 0,
      width = 20,
      height = 20,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJxjYBgFtAB1UExNswareaNgFIyCkQkA9GcD8Q=="
    },
    {
      type = "tilelayer",
      name = "ground",
      x = 0,
      y = 0,
      width = 20,
      height = 20,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJx9lNsNxDAIBN2J6SA0cXWl9dNJRprMQT6QEx4LLMa51rqOJL639Huwly10MoZCnA25Tmyek/UkbF1NxHP+EDb7MmbpQjix/usNYNGv6rmPlP4j2QMusUpuSMW84XU1s0fjdfXFes4617N34ody7KG+jivPIJSD/oXL2eZ69ksd78k0X+Ykh+yF/uTYdTvX5DP5vu2LxTvqvcrhjBf/jofyIb+eIWfr+2G+3IP32zbOOYZ/v0Wuv9tb9tVhd3efMVMe82t917v59RtbfJofz8+73+n8dndvBLlg//b92b8YJEMr"
    },
    {
      type = "tilelayer",
      name = "road",
      x = 0,
      y = 0,
      width = 20,
      height = 20,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJxjYBgF1AT5VDbPZxCbZ0tF8+yhZgVQyTyQWX5EqCM2voj150CqsyOghpT48oeqJYSpFV+jYGgCAGVeCQM="
    },
    {
      type = "tilelayer",
      name = "tile",
      x = 0,
      y = 0,
      width = 20,
      height = 20,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["collidable"] = true
      },
      encoding = "base64",
      compression = "zlib",
      data = "eJylVDEOwjAMzErpB8LOkB0kHsATEBMZYWMDHlHgBXwWV/JJh+WkjTjpFNdJz67jOoUQojApV7QyI/kj+fFepDMtgIYH6Lbo1OIj7yn0woVhX9Ar5XcQHtXuhGu1r8Kz+oBBV9TX0xpxIT2LTnVwL9BDfk86exPehY+C3qYQY6q+nAtjX9Cr1e9F9pIYjG3zm9svI94T+16/eDnjmWvj1arUfy05M/Av/otEa+v/azUYtfudiy3ZPCuy8OSwBVy/7OznMK8eO135flnvU4lRAnoZ8b1vrekNjs/OeTvfsR/D75xPlTNfkzMaYA=="
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
          id = 61,
          name = "player",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 224,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["imgx"] = 2,
            ["imgy"] = 1
          }
        },
        {
          id = 64,
          name = "monster1",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 160,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["imgx"] = 4,
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
          id = 70,
          name = "door",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 128,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true,
            ["open"] = false
          }
        },
        {
          id = 72,
          name = "chest",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 64,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        }
      }
    }
  }
}
