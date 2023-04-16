Jogo = Classe:extend()

function Jogo:new()
    cenario = Cenario()
    player = Player()
    bosses = Bosses()
end

function Jogo:update(dt)
    player:update(dt)
    bosses:update(dt)
    boss = bosses:getBoss()
    if #bosses.sequence == #player.sequence then

        if verificaSequencia(player.sequence,bosses.sequence) then
            boss.life = boss.life - #bosses.sequence
        else
            player.life = player.life - 2
        end

        bosses.sequence = nil
        player.sequence = {}
    end
  
    -- Checar vida do boss
    if boss.life <= 0 then
        bosses = Bosses()
    end
end

function Jogo:draw()
    cenario:draw()
    player:draw()
    bosses:draw()
    Display()
end

function verificaSequencia(playerSequence, bossSequence)
    for i, key in ipairs(playerSequence) do
        if playerSequence[i] ~= bossSequence[i] then
            return false
        end
    end

    return true
end

function Display()
    local font1 = love.graphics.newFont("fonts/Minecrafter.Alt.ttf", 16)
    local font2 = love.graphics.newFont("fonts/Minecraft.ttf", 16)

    -- Sequence
    love.graphics.setFont(font1)
    love.graphics.newText(font1,s)
    x = love.graphics.getWidth()
    x, y = x/2, 80
    love.graphics.print(s, x-font1.getWidth(font1,s)/2, y, 0, 1,1,0)

    -- Player Life
    local font = love.graphics.newFont("fonts/Minecraft.ttf", 16)
    love.graphics.setFont(font2)
    love.graphics.newText(font2,s)

    player_text = 'HP: '..tostring(player.life)
    love.graphics.print(player_text, player.x-font.getWidth(font,player_text)/2 + 25, player.y-40)


    -- Boss life
    if boss ~= nil then
        boss_text = 'HP: '..tostring(boss.life)
        love.graphics.print(boss_text, boss.x-font.getWidth(font,boss_text)/2 + 25, boss.y-40)
    end
end