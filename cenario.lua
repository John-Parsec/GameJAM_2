Cenario = Classe:extend()

function Cenario:new()
    
end

function Cenario:update(dt)

end

function Cenario:draw()
    local red = 27/255
    local green = 28/255
    local blue = 30/255
    local alpha = 100/100
    love.graphics.setBackgroundColor( red, green, blue, alpha)
end