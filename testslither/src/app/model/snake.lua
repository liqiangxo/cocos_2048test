local snake = class("snake",  function()
    return display.newNode("snake")
end)
local CircleBase = require "app.model.CircleBase"

function snake:ctor (data)
    local color = data.color
    local length = data.length
    local radius = data.radius

    self.snakeQure
    for i=1,5 do
        local circle = CircleBase.new({radius = data.radius,color = cc.WHITE})
        circle:setPosition(display.cx, display.cy)
        self:addChild(circle)
    end
end

return snake
