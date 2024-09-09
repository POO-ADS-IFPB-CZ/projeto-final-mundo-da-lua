local screens = {}
local currentScreen = "menu"

function love.load()
    love.window.setMode(800, 600, {
        resizable = true,   -- Permite redimensionar a janela
        minwidth = 800,     -- Largura mínima
        minheight = 600     -- Altura mínima
    })

    -- Carregar as telas
    screens.menu = require "screens.menu"
    screens.screen1 = require "screens.screen1"
    screens.screen2 = require "screens.screen2"
    screens.screen3 = require "screens.screen3"
    screens.screen4 = require "screens.screen4"
    
    -- Inicializar a tela principal
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

-- Função para mudar de tela
function changeScreen(screenName)
    if screens[screenName] then
        currentScreen = screenName
        screens[currentScreen].load()
    end
end