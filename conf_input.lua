local Input = require("lib/input")

local input = Input()

input:bind("left", "left")
input:bind("right", "right")
input:bind("up", "up")
input:bind("down", "down")
input:bind("return", "interact")

input:bind("space", "toggle_camera")

input:bind("escape", "quit_game")

return input
