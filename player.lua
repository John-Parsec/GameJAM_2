Player = Classe:extend()

function Player:new()
    self.w = 14
    self.h = 13
    self.x = 5 * self.w
    self.y = love.graphics.getHeight()/2
    self.life = 10
    self.sequence = {}
    self.spriteSlime = SlimeAnimation(love.graphics.newImage("images/player/idle.png"), self.w, self.h, 1)
end

function Player:update(dt)
    self.spriteSlime.currentTime = self.spriteSlime.currentTime + dt
    if self.spriteSlime.currentTime >= self.spriteSlime.duration then
        self.spriteSlime.currentTime = self.spriteSlime.currentTime - self.spriteSlime.duration
    end
end

function Player:draw()
    local spriteNum = math.floor(self.spriteSlime.currentTime / self.spriteSlime.duration * #self.spriteSlime.quads) + 1
    love.graphics.draw(self.spriteSlime.spriteSheet, self.spriteSlime.quads[spriteNum], self.x, self.y, 0, 4)
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

function love.keypressed( key )
    if key == "up" then
       table.insert(player.sequence, key)
    end
    if key == "down" then
        table.insert(player.sequence, key)
     end
     if key == "left" then
        table.insert(player.sequence, key)
     end
     if key == "right" then
        table.insert(player.sequence, key)
     end
 end