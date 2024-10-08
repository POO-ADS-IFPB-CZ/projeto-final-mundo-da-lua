local screens = {}
local currentScreen = "menu"
myFont = nil

-- Importing
require("functions.dao")
require("classes.filme")
require("screenFunctions.layout")

-- Window config
love.window.setMode(800, 600, {
    resizable = true,
    minwidth = 1080,   
    minheight = 720  
})

function love.load()
    -- Load the font 
    myFont = love.graphics.newFont("fonts/zenKaku.ttf", 26)
    love.graphics.setFont(myFont)

    -- Load screens
    screens.menu = require "screens.menu"
    screens.adicionarFilme = require "screens.adicionarFilme"
    screens.adicionarSerie = require "screens.adicionarSerie"
    screens.adicionarRealityShow = require "screens.adicionarRealityShow"
    
    -- Initialize menu
    screens.menu.load()
end

function love.update(dt)
    if screens[currentScreen] and screens[currentScreen].update then
        screens[currentScreen].update(dt)
    end
end

function love.draw()
    if screens[currentScreen] and screens[currentScreen].draw then
        screens[currentScreen].draw()
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if screens[currentScreen] and screens[currentScreen].mousepressed then
        screens[currentScreen].mousepressed(x, y, button, istouch, presses)
    end
end

function love.keypressed(key)
    if screens[currentScreen] and screens[currentScreen].keypressed then
        screens[currentScreen].keypressed(key)
    end
end

function love.textinput(t)
    if screens[currentScreen] and screens[currentScreen].textinput then
        screens[currentScreen].textinput(t)
    end
end

function love.mousemoved(x, y, dx, dy, istouch)
    if screens[currentScreen] and screens[currentScreen].mousemoved then
        screens[currentScreen].mousemoved(x, y, dx, dy, istouch)
    end
end

function love.update(dt)
    if screens[currentScreen] and screens[currentScreen].update then
        screens[currentScreen].update(dt)
    end
end

function love.wheelmoved(x, y)
    if screens[currentScreen] and screens[currentScreen].wheelmoved then
        screens[currentScreen].wheelmoved(x, y)
    end
end

-- Função para mudar de tela
function changeScreen(screenName, addin)
    addin = addin or nil
    if (not addin) then
        if screens[screenName] then
            currentScreen = screenName
            screens[currentScreen].load()
        end
    else
        if screens[screenName] then
            currentScreen = screenName
            screens[currentScreen].load(addin)
        end
    end
end