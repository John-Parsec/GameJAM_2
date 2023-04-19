Classe = require "classic"
require "jogo"
require "bosses"
require "bossSpirit"
require "player"
require "cenario"
require "love.timer"

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