Bosses = Classe:extend()

function Bosses:new()
    self.bossNumber = 1
    self.sequence = nil
    self.bossSpirit = BossSpirit()
end

function Bosses:update(dt)
    if self.bossNumber == 1 then
        self.bossSpirit:update(dt)

        if self.sequence == nil then
            self.sequence = self.bossSpirit:createSequence()
            s = ''
            for i=1, #self.sequence do
                s = s..tostring(self.sequence[i])..' '
            end
        end
    end
end

function Bosses:draw()
    if self.bossNumber == 1 then
        self.bossSpirit:draw()
    end
end

function Bosses:getBoss()
    return self.bossSpirit
end