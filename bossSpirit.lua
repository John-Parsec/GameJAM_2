BossSpirit = Classe:extend()

keys = {"up", "down", "left", "right"}

function BossSpirit:new()
    self.w = 14
    self.h = 19
    self.x = love.graphics.getWidth() - (10 * self.w)
    self.y = (love.graphics.getHeight()/2) - (5 * self.h)
    self.life = 50
    self.spriteSpirit = BossSpiritAnimation(love.graphics.newImage("images/bosses/Spirit_Idle.png"), self.w, self.h, 1)
end

function BossSpirit:update(dt)
    self.spriteSpirit.currentTime = self.spriteSpirit.currentTime + dt
    if self.spriteSpirit.currentTime >= self.spriteSpirit.duration then
        self.spriteSpirit.currentTime = self.spriteSpirit.currentTime - self.spriteSpirit.duration
    end
end

function BossSpirit:draw()
    local spriteNum = math.floor(self.spriteSpirit.currentTime / self.spriteSpirit.duration * #self.spriteSpirit.quads) + 1
    love.graphics.draw(self.spriteSpirit.spriteSheet, self.spriteSpirit.quads[spriteNum], self.x, self.y, 0, 4)
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

function BossSpirit:createSequence()
    local x = 0
    local sequence = {}

    for i = 1, 5 do
        x = math.random(1, 4)
        table.insert(sequence, keys[x])
    end

    return sequence
end

function BossSpirit:deleteSequence(sequence)
    for i, key in ipairs(sequence) do
        table.remove(sequence, i)
    end
end