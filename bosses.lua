Bosses = Classe:extend()

function Bosses:new()
    self.bossNumber = 1
    self.sequence = nil
    bossSpirit = BossSpirit()
end

function Bosses:update(dt)
    if self.bossNumber == 1 then
        bossSpirit:update(dt)
        
        if self.sequence == nil then
            self.sequence = bossSpirit:createSequence()

            for i=1, #self.sequence do
                print(self.sequence[i])
            end
        end
    end
end

function Bosses:draw()
    if self.bossNumber == 1 then
        bossSpirit:draw()
    end
end