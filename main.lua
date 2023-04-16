Classe = require "classic"
require "jogo"
require "bosses"
require "player"
require "cenario"

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    jogo = Jogo()
end

function love.update(dt)
    jogo:update(dt)
end

function love.draw()
    jogo:draw()
end