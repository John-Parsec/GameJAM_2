Jogo = Classe:extend()

function Jogo:new()
    self.game = true
    self.cont = 1
    self.verificaSequencia = true
    self.initialTime = love.timer.getTime()
    self.minutes = 0
    self.seconds = 0
    cenario = Cenario()
    player = Player()
    bosses = Bosses()
end

function Jogo:update(dt)
    if self.game then
        player:update(dt)
        bosses:update(dt)
        boss = bosses:getBoss()

        if not self.verificaSequencia then
            player:playerHit()
            player.life = player.life - 2

            self.cont = 1
            self.verificaSequencia = true
            bosses.qtdeSequences = bosses.qtdeSequences + 1
            bosses.sequence = {}
            player.sequence = {}
            
        elseif #bosses.sequence == #player.sequence then

            if self.verificaSequencia then
                boss.life = boss.life - #bosses.sequence
                boss.bossSpiritHit()
            end

            self.cont = 1
            self.verificaSequencia = true
            bosses.qtdeSequences = bosses.qtdeSequences + 1
            bosses.sequence = {}
            player.sequence = {}
        end
    
        -- Checar vida do player
        if player.life <= 0 then
            player:playerDeath()
            self.game = false
        end

        -- Checar vida do boss
        if boss.life <= 0 then
            if bosses.bossNumber == 1 then
                boss:bossSpiritDeath()
                bosses.bossNumber = 1
            end
            
            if bosses.bossNumber == 1 then
                self.game = false
            end
        end
    elseif player.life > 0 then
        --Atualiza o melhor tempo
        if jogo.minutes < player.bestTimeMinutes or player.firstPlay then
            player.firstPlay = false
            player.bestTimeMinutes = jogo.minutes
            player.bestTimeSeconds = jogo.seconds
        elseif jogo.minutes == player.bestTimeMinutes and jogo.seconds < player.bestTimeSeconds then
            player.bestTimeMinutes = jogo.minutes
            player.bestTimeSeconds = jogo.seconds
        end
    end
end

function Jogo:draw()
    cenario:draw()
    DisplayBestTime()

    if self.game then
        player:draw()
        bosses:draw()
        Display()
    else
        DisplayEnd()
    end
end

function Display()
    local font1 = love.graphics.newFont("fonts/Minecrafter.Alt.ttf", 16)
    local font2 = love.graphics.newFont("fonts/Minecraft.ttf", 16)

    --Timer
    love.graphics.setFont(font2)
    jogo.seconds = love.timer.getTime() - jogo.initialTime
    if jogo.seconds >= 60 then
        jogo.minutes = jogo.minutes + 1
        jogo.initialTime = love.timer.getTime()
    end
    timer_text = 'Timer:  '..tostring(jogo.minutes)..':'..tostring(jogo.seconds)
    love.graphics.print(timer_text, love.graphics.getWidth() * 0.05, love.graphics.getHeight() * 0.05)

    -- Sequence
    love.graphics.setFont(font1)
    love.graphics.newText(font1,s)
    x = love.graphics.getWidth()
    x, y = x/2, 80
    love.graphics.print(s, x-font1.getWidth(font1,s)/2, y, 0, 1,1,0)

    -- Player Life
    love.graphics.setFont(font2)
    love.graphics.newText(font2,s)

    player_text = 'HP: '..tostring(player.life)
    love.graphics.print(player_text, player.x-font2.getWidth(font2,player_text)/2 + 25, player.y-40)


    -- Boss life
    if boss ~= nil then
        boss_text = 'HP: '..tostring(boss.life)
        love.graphics.print(boss_text, boss.x-font2.getWidth(font2,boss_text)/2 + 25, boss.y-40)
    end
end

function DisplayEnd()
    local font1 = love.graphics.newFont("fonts/Minecraft.ttf", 16)

    end_text = 'Aperte ESC ou SPACE para reiniciar'
    love.graphics.setFont(font1)
    love.graphics.newText(font1,end_text)
    x = love.graphics.getWidth()
    y = love.graphics.getHeight()
    x, y = x/2, y/2
    love.graphics.print(end_text, x-font1.getWidth(font1,end_text)/2, y-font1.getHeight(font1,end_text)/2, 0, 1,1,0)
end

function DisplayBestTime()
    local font1 = love.graphics.newFont("fonts/Minecraft.ttf", 16)

    bestTime_text = 'Melhor tempo: '..tostring(player.bestTimeMinutes)..':'..tostring(player.bestTimeSeconds)
    love.graphics.setFont(font1)
    love.graphics.newText(font1,bestTime_text)
    x = love.graphics.getWidth()
    y = love.graphics.getHeight()
    x, y = x * 0.85, y * 0.85
    love.graphics.print(bestTime_text, x-font1.getWidth(font1,bestTime_text)/2, y-font1.getHeight(font1,bestTime_text)/2, 0, 1,1,0)
end

function love.keypressed( key )
    if jogo.game then
        if bosses.sequence[jogo.cont] == key then
            jogo.cont = jogo.cont + 1
            table.insert(player.sequence, key)
        else
            jogo.verificaSequencia = false
        end

        if bosses.bossNumber == 1 then
            if key == "up" or key == "down" or key == "left" or key == "right" then
                buttomSound:stop()
                buttomSound:play()
            end
        end
    else
        if key == "space" or key == "escape" then
            cenario = Cenario()
            player.life = 10
            bosses = Bosses()
            jogo.game = true
            jogo.cont = 1
            jogo.verificaSequencia = true
            jogo.initialTime = love.timer.getTime()
            jogo.minutes = 0
            jogo.seconds = 0
        end
    end
 end