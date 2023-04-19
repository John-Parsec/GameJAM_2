BossSpirit = Classe:extend()

keys = {"up", "down", "left", "right"}
deathSoundSpirit = love.audio.newSource("sounds/Death Sound 1.mp3", "stream")
hitSoundSpirit = love.audio.newSource("sounds/Denied.mp3", "stream")

function BossSpirit:new()
    self.w = 14
    self.h = 19
    self.x = love.graphics.getWidth() - (10 * self.w)
    self.y = (love.graphics.getHeight()/2) - (5 * self.h)
    self.life = 60
    self.tamSquence = 3
    self.max = 8
    self.spriteSpirit = BossSpiritAnimation(love.graphics.newImage("images/bosses/Spirit_Idle.png"), self.w, self.h, 1)
    self.spriteSpiritHit = BossSpiritAnimation(love.graphics.newImage("images/bosses/Spirit_Hit.png"), 17, 18, 1)
end

function BossSpirit:update(dt)
    if not hitSoundSpirit:isPlaying() then 
        self.spriteSpirit.currentTime = self.spriteSpirit.currentTime + dt
        if self.spriteSpirit.currentTime >= self.spriteSpirit.duration then
            self.spriteSpirit.currentTime = self.spriteSpirit.currentTime - self.spriteSpirit.duration
        end
    else
        self.spriteSpiritHit.currentTime = self.spriteSpiritHit.currentTime + dt
        if self.spriteSpiritHit.currentTime >= self.spriteSpiritHit.duration then
            self.spriteSpiritHit.currentTime = self.spriteSpiritHit.currentTime - self.spriteSpiritHit.duration
        end
    end
end

function BossSpirit:draw()
    if not hitSoundSpirit:isPlaying() then 
        local spriteNum = math.floor(self.spriteSpirit.currentTime / self.spriteSpirit.duration * #self.spriteSpirit.quads) + 1
        love.graphics.draw(self.spriteSpirit.spriteSheet, self.spriteSpirit.quads[spriteNum], self.x, self.y, 0, 4)
    else
        local spriteNum = math.floor(self.spriteSpiritHit.currentTime / self.spriteSpiritHit.duration * #self.spriteSpiritHit.quads) + 1
        love.graphics.draw(self.spriteSpiritHit.spriteSheet, self.spriteSpiritHit.quads[spriteNum], self.x, self.y, 0, 4)
    end
end

function BossSpiritAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image
    animation.quads = {}

    for y = 0, image:getHeight() - height, 44 do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end

    animation.duration = duration or 1
    animation.currentTime = 0

    return animation
end

function BossSpirit:bossSpiritDeath()
    deathSoundSpirit:play()
end

function BossSpirit:bossSpiritHit()
    hitSoundSpirit:stop()
    hitSoundSpirit:play()
end

function BossSpirit:createSequence()
    local x = 0
    local sequence = {}
    math.randomseed(os.time())

    for i = 1, self.tamSquence do
        x = math.random(1,4)
        table.insert(sequence, keys[x])
    end

    return sequence
end

function BossSpirit:deleteSequence(sequence)
    for i, key in ipairs(sequence) do
        table.remove(sequence, i)
    end
end