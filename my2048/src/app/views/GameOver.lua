local GameOver = class("GameOver",cc.load("mvc").ViewBase)

local SetScene = require("src.app.views.SetScene")
local headerlayer = require("src.app.views.headerlayer")
function GameOver:onCreate ()

  self:addChild(headerlayer.new(headType.headType_No_return,self,""))
        local reStrar = cc.MenuItemFont:create("reStrar")
            :onClicked(function()
                self:getApp():enterScene("startScene")
            end)
        local playButton = cc.MenuItemFont:create("MainScene")
            :onClicked(function()
                self:getApp():enterScene("MainScene")
            end)
        local setButton = cc.MenuItemFont:create("Settings")
            :onClicked(function()
                self:addChild(SetScene.new())
            end)
        cc.Menu:create(reStrar,playButton,setButton)
            :move(display.cx, display.cy -display.cy/6.4)
            :addTo(self)
            :alignItemsHorizontally()
            :alignItemsHorizontallyWithPadding(50)

        cc.Label:createWithSystemFont("GamaOver", "Arial", 50)
            :move(display.cx, display.cy)
            :addTo(self)


        local maxScore = cc.UserDefault:getInstance():getIntegerForKey(GameConstants.GameDatas.maxScore)
        local curScore = cc.UserDefault:getInstance():getIntegerForKey(GameConstants.GameDatas.curScore)
        local allScore = cc.UserDefault:getInstance():getIntegerForKey(GameConstants.GameDatas.allScore)


end




return GameOver
