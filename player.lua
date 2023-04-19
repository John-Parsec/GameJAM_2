Player = Classe:extend()

buttomSound = love.audio.newSource("sounds/Hitsound 1.mp3", "stream")
deathSound = love.audio.newSource("sounds/Death Sound 4.mp3", "stream")
hitSound = love.audio.newSource("sounds/Denied.mp3", "stream")

function Player:new()
    self.w = 14
    self.h = 13
    self.x = 5 * self.w
    self.y = love.graphics.getHeight()/2
    self.life = 10
    self.sequence = {}
    self.firstPlay = true
    self.bestTimeMinutes = 0
    self.bestTimeSeconds = 0
    self.spriteSlime = SlimeAnimation(love.graphics.newImage("images/player/idle.png"), self.w, self.h, 1)
    self.spriteSlimeHit = SlimeAnimation(love.graphics.newImage("images/player/hit.png"), 14, 14, 0.4)
end

function Player:update(dt)
    if not hitSound:isPlaying() then 
        self.spriteSlime.currentTime = self.spriteSlime.currentTime + dt
        if self.spriteSlime.currentTime >= self.spriteSlime.duration then
            self.spriteSlime.currentTime = self.spriteSlime.currentTime - self.spriteSlime.duration
        end
    else
        self.spriteSlimeHit.currentTime = self.spriteSlimeHit.currentTime + dt
        if self.spriteSlimeHit.currentTime >= self.spriteSlimeHit.duration then
            self.spriteSlimeHit.currentTime = self.spriteSlimeHit.currentTime - self.spriteSlimeHit.duration
        end
    end
end

function Player:draw()

    if not hitSound:isPlaying() then 
        local spriteNum = math.floor(self.spriteSlime.currentTime / self.spriteSlime.duration * #self.spriteSlime.quads) + 1
        love.graphics.draw(self.spriteSlime.spriteSheet, self.spriteSlime.quads[spriteNum], self.x, self.y, 0, 4)
    else
        local spriteNum = math.floor(self.spriteSlimeHit.currentTime / self.spriteSlimeHit.duration * #self.spriteSlimeHit.quads) + 1
        love.graphics.draw(self.spriteSlimeHit.spriteSheet, self.spriteSlimeHit.quads[spriteNum], self.x, self.y, 0, 4)
    end
end

function SlimeAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image
    animation.quads = {}

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, 64 do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end

    animation.duration = duration or 1
    animation.currentTime = 0

    return animation
end

function Player:removeSequence()
    self.sequence = {}
end

function Player:playerDeath()
    deathSound:play()
end

function Player:playerHit()
    hitSound:stop()
    hitSound:play()
end