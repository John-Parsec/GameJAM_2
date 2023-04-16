Player = Classe:extend()

function Player:new()
    self.spriteSlime = SlimeAnimation(love.graphics.newImage("images/player/idle.png"), 14, 13, 1)
end

function Player:update(dt)
    self.spriteSlime.currentTime = self.spriteSlime.currentTime + dt
    if self.spriteSlime.currentTime >= self.spriteSlime.duration then
        self.spriteSlime.currentTime = self.spriteSlime.currentTime - self.spriteSlime.duration
    end
end

function Player:draw()
    local spriteNum = math.floor(self.spriteSlime.currentTime / self.spriteSlime.duration * #self.spriteSlime.quads) + 1
    love.graphics.draw(self.spriteSlime.spriteSheet, self.spriteSlime.quads[spriteNum], 50, love.graphics.getHeight()/2, 0, 4)
end

function SlimeAnimation(image, width, height, duration)
    local animation = {};
    animation.spriteSheet = image;
    animation.quads = {};

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, 64 do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end

    animation.duration = duration or 1
    animation.currentTime = 0

    return animation
end