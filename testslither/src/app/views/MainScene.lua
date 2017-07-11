
local MainScene = class("MainScene", cc.load("mvc").ViewBase)
local CircleBase = require "app.model.CircleBase"
local map = require "app.model.map"

function MainScene:onCreate()

    -- self.gamemap = map.new({radius = 600,color = cc.WHITE})
    -- self.gamemap:setPosition(display.cx, display.cy)
    -- self:addChild(self.gamemap)


    self.snakeContainer = display.newNode()
    self:addChild(self.snakeContainer,20)
    -- for i=1,20 do
        local circle = CircleBase.new({radius = 30,color = cc.c3b(math.random(0, 255),math.random(0, 255),math.random(0, 255))})
        circle:setPosition(math.random(0, 1136), math.random(0, 640))
        self.snakeContainer:addChild(circle)
    -- end
    self.layer1 = display.newLayer(cc.c4b(220,200,200,200),cc.size(123,123))
    self:addChild(self.layer1);

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:setSwallowTouches(true)
    listener:registerScriptHandler(function(touches, event)
        return true
    end,cc.Handler.EVENT_TOUCH_BEGAN )

    local eventDispatcher = scene:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self.layer1)

    local listener =

end

function MainScene:createSomeColorLayer() (args)
    -- body...
end

return MainScene
