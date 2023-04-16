Jogo = Classe:extend()

function Jogo:new()
    cenario = Cenario()
    player = Player()
    bosses = Bosses()
end

function Jogo:update(dt)
    player:update(dt)
    bosses:update(dt)
end

function Jogo:draw()
    cenario:draw()
    player:draw()
    bosses:draw()
end

function verificaColisao(player, box)
    if player.x < box.x + box.w and
        player.x  + (player.scale * player.sprite:getWidth())> box.x and
        player.y < box.y + box.h and
        player.y + (player.scale * player.sprite:getHeight()) > box.y then
            return true
    end
end