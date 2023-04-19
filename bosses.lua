Bosses = Classe:extend()

function Bosses:new()
    self.bossNumber = 1
    self.sequence = {}
    self.qtdeSequences = 0
    self.bossSpirit = BossSpirit()
end

function Bosses:update(dt)
    if self.bossNumber == 1 then
        self.bossSpirit:update(dt)

        if #self.sequence == 0 then
            self.sequence = self.bossSpirit:createSequence()
            s = ''
            for i=1, #self.sequence do
                s = s..tostring(self.sequence[i])..' '
            end
        end
        
        if self.qtdeSequences == 3 and self.bossSpirit.tamSquence < self.bossSpirit.max then
            self.bossSpirit.tamSquence = self.bossSpirit.tamSquence + 2
            self.qtdeSequences = 0
        end
    end
end

function Bosses:draw()
    if self.bossNumber == 1 then
        self.bossSpirit:draw()
    end
end

function Bosses:getBoss()
    if self.bossNumber == 1 then
        return self.bossSpirit 
    end
end