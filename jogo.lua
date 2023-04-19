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
            bosses.sequence = nil
            player.sequence = {}
            
        elseif #bosses.sequence == #player.sequence then

            if self.verificaSequencia then
                boss.life = boss.life - #bosses.sequence
                boss.bossSpiritHit()
            end

            self.cont = 1
            self.verificaSequencia = true
            bosses.sequence = nil
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
                --bosses.bossNumber = 2
            end
            
            if bosses.bossNumber == 1 then
                self.game = false
            end
        end
    end
end

function Jogo:draw()
    cenario:draw()

    if self.game then
        player:draw()
        bosses:draw()
        Display()
    end
end

function Display()
    local font1 = love.graphics.newFont("fonts/Minecrafter.Alt.ttf", 16)
    local font2 = love.graphics.newFont("fonts/Minecraft.ttf", 16)
    local font3 = love.graphics.newFont("fonts/Cave-Story.ttf", 16)

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

function love.keypressed( key )
    if jogo.game then
        if bosses.sequence[jogo.cont] == key then
            jogo.cont = jogo.cont + 1
            table.insert(player.sequence, key)
        else
            jogo.verificaSequencia = false
        end

        if bosses.bossNumber == 1 then
            if key == "up" or key == "down" or key == "left" or key == "right"then
                buttomSound:stop()
                buttomSound:play()
            end
        end
    else
        if key == "space" or key == "escape" then
            cenario = Cenario()
            player = Player()
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