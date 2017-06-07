function love.conf(t)
    t.identity              = nil
    t.version               = "0.10.1"
    t.console               = false
    t.accelerometerjoystick = false
    t.externalstorage       = false
    t.gammacorrect          = false

    t.window.title          = "Test RPG"
    t.window.icon           = nil
    t.window.width          = 800
    t.window.height         = 600
    t.window.borderless     = false
    t.window.resizable      = false
    t.window.minwidth       = 1
    t.window.minheight      = 1
    t.window.fullscreen     = false
    t.window.fullscreentype = "exclusive"
    t.window.vsync          = true
    t.window.msaa           = 0
    t.window.display        = 1
    t.window.highdpi        = false
    t.window.x              = nil
    t.window.y              = nil

    t.modules.audio         = false
    t.modules.event         = true
    t.modules.graphics      = true
    t.modules.image         = true
    t.modules.joystick      = false
    t.modules.keyboard      = true
    t.modules.math          = true
    t.modules.mouse         = false
    t.modules.physics       = true
    t.modules.sound         = false
    t.modules.system        = true
    t.modules.timer         = true
    t.modules.touch         = false
    t.modules.video         = false
    t.modules.window        = true
    t.modules.thread        = false
end
