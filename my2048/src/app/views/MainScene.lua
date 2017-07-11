
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

require "app.views.GameConstants"
require "app.views.Player"
require "app.views.pupWind"
require "app.views.SceneManager"
local headerlayer = require("src.app.views.headerlayer")
local requre = require("src.app.views.requre")
local SetScene = require("src.app.views.SetScene")

function MainScene:onCreate()

    -- add play button
    -- cc.UserDefault:getInstance():setIntegerForKey("Pass",1)
    --Integer,Double,Bool,Float,String,
    cc.UserDefault:getInstance():flush()
    -- 在writablePath路径下会生成UserDefault.xml文件
    -- 获取数据
    local player = player.getInstance()
    local MusicVolume = player:getUserDefaultFloat(GameConstants.GameSettings.MusicVolume)
    audio.setMusicVolume(MusicVolume)
    local SoundsVolume = player:getUserDefaultFloat(GameConstants.GameSettings.SoundsVolume)
    audio.setSoundsVolume(SoundsVolume)
    self:addChild(headerlayer.new(headType.headType_No_return,self,""))
    -- print("MainScene",audio.isMusicPlaying())
    if audio.isMusicPlaying()==false then
      audio.playMusic("backmusic.mp3")
    end
      local playButton = cc.MenuItemFont:create("start")
          :onClicked(function()
            SceneManager.getInstance():gotoScene(self,"startScene")
              self:getApp():enterScene("startScene","RANDOM",1)
          end)
      local TaskButton = cc.MenuItemFont:create("TaskButton")
          :onClicked(function()
              self:getApp():enterScene("taskSys","RANDOM")
          end)
      local setButton = cc.MenuItemFont:create("Settings")
          :onClicked(function()
              self:addChild(SetScene.new())
          end)
      local bpButton = cc.MenuItemFont:create("backpack")
          :onClicked(function()
              self:getApp():enterScene("backpack","RANDOM")
          end)

      cc.Menu:create(playButton,TaskButton,setButton,bpButton)
          :move(display.cx, display.cy )
          :addTo(self)
          :alignItemsVertically()
          :alignItemsVerticallyWithPadding(50)

      -- for i=1,4 do
      -- 	for j=1,4 do
      --   	math.randomseed(os.time())
    	--     local z = math.floor(math.random(1,2,3,3,3,3,3,3))
      --     if z == 1 or z == 2 then
      --         local requreone = requre.new(tonumber(z),i,j)
      --         -- requreone:setNum(z)
      -- 		    self:addChild(requreone)
      --     end
      -- 	end
      -- end

    local maxScore = player:getUserDefaultInt(GameConstants.GameDatas.maxScore)
    local curScore = player:getUserDefaultInt(GameConstants.GameDatas.curScore)
    local allScore = player:getUserDefaultInt(GameConstants.GameDatas.allScore)
    local gameOpenAmount = player:getUserDefaultInt(GameConstants.GameDatas.gameOpenAmount)
    local GameGold = player:getUserDefaultInt(GameConstants.GameDatas.GameGold)


    local scheduler=cc.Director:getInstance():getScheduler()
    self.schenum = scheduler:scheduleScriptFunc(function  (dt)
    	math.randomseed(os.time())

      --检查是否有任务奖励可以领取
        if player.getInstance():isHaveTaskGet() then
          local action1 = cc.MoveBy:create(0.1,cc.p(-30,0))
          local action2 = cc.MoveBy:create(0.1,cc.p(60,0))
          TaskButton:setColor(cc.c4f(244,40,40))
          TaskButton:runAction(cc.Sequence:create(action1,action2,action1))
        end
    end,3,false)

end
function MainScene:onExit()
    local scheduler=cc.Director:getInstance():getScheduler()
    scheduler:unscheduleScriptEntry(self.schenum)
end


return MainScene
