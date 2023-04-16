Jogo = Classe:extend()

function Jogo:new()
    cenario = Cenario()
    player = Player()
    bosses = Bosses()
end

function Jogo:update(dt)
    player:update(dt)
    bosses:update(dt)

    if #bosses.sequence == #player.sequence then
        print(verificaSequencia(player.sequence, bosses.sequence))
    end
end

function Jogo:draw()
    cenario:draw()
    player:draw()
    bosses:draw()
end

function verificaSequencia(playerSequence, bossSequence)
    for i, key in ipairs(playerSequence) do
        if playerSequence[i] ~= bossSequence[i] then
            return false
        end
    end

    return true
end