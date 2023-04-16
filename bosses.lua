Bosses = Classe:extend()

function Bosses:new()
    self.bossNumber = 1
    self.w = 14
    self.h = 19
    self.spriteSpirit = BossAnimation(love.graphics.newImage("images/bosses/Spirit_Idle.png"), self.w, self.h, 1)
end

function Bosses:update(dt)
    if self.bossNumber == 1 then
        self.spriteSpirit.currentTime = self.spriteSpirit.currentTime + dt
        if self.spriteSpirit.currentTime >= self.spriteSpirit.duration then
            self.spriteSpirit.currentTime = self.spriteSpirit.currentTime - self.spriteSpirit.duration
        end
    end
end

function Bosses:draw()
    if self.bossNumber == 1 then
        local spriteNum = math.floor(self.spriteSpirit.currentTime / self.spriteSpirit.duration * #self.spriteSpirit.quads) + 1
        love.graphics.draw(self.spriteSpirit.spriteSheet, self.spriteSpirit.quads[spriteNum], love.graphics.getWidth() - (10 * self.w), (love.graphics.getHeight()/2) - (3 * self.h) , 0, 4)
    end
end

function BossAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};

    for y = 0, image:getHeight() - height, 44 do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end

    animation.duration = duration or 1
    animation.currentTime = 0

    return animation
end