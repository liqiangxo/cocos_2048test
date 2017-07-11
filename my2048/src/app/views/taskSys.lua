
local taskSys = class("taskSys",cc.load("mvc").ViewBase)

local headerlayer = require("src.app.views.headerlayer")
-- -- 加载csb文件
taskSys.RESOURCE_FILENAME = "taskSys.csb"

-- 获取UI控件
taskSys.RESOURCE_BINDING = {
    ["ListView_task"]   = {["varname"] = "ListView_task"},
    ["Button_exit"] = {["varname"] = "Button_exit"},
    ["Particle_xingxing"] = {["varname"] = "Particle_xingxing"},
    ["Text_Task"] = {["varname"] = "Text_Task"},
    ["Button_resert"] = {["varname"] = "Button_resert"}
}

-- -- 加载csb文件
taskSys.RESOURCE_FILENAME2 = "oneTest.csb"




function taskSys:onCreate ()


    local player = player.getInstance()
      -- 按钮使用
      self.Button_exit:addClickEventListener(function(sender)
          self:getApp():enterScene("MainScene","RANDOM")
      end)
      self.Button_exit:setVisible(false)
      self.Particle_xingxing:setVisible(false)
      self.Button_resert:addClickEventListener(function  (sender)

          for i,v in ipairs(GameConstants.taskData) do
            for j,k in ipairs(v) do
              player:setUserDefaultBool(GameConstants.GameDatas.TaskIsGet..i..j,false)
              self:newListView()
            end
          end
      end)
      -- self.ListView_task:setVisible(false)

      -- local node = cc.CSLoader:createNode(taskSys.RESOURCE_FILENAME2)
      -- local default_item = ccui.Layout:create()
      -- default_item:setTouchEnabled(true)
      -- default_item:addChild(node)
      --
      -- self.ListView_task:setItemModel(default_item)

      -- self.ListView_task:pushBackDefaultItem()


      -- local scheduler=cc.Director:getInstance():getScheduler()
      -- scheduler:scheduleScriptFunc(function  (dt)
      -- 	math.randomseed(os.time())
      --   local pointxingxing_zuo = cc.p(-math.random(0,display.width/2),math.random(-display.height/2,display.height*1.5))
      --
      --   -- self.Particle_xingxing:runAction(cc.moveTo:create(3,p1))
      -- end,3,false)

      self:newListView()
      self:addChild(headerlayer.new(headType.headType_scene,self,"MainScene"))

end
function taskSys:newListView()
    local player = player.getInstance()
  self.ListView_task:removeAllItems()
  local maxScore = player:getUserDefaultInt(GameConstants.GameDatas.maxScore)
  local curScore = player:getUserDefaultInt(GameConstants.GameDatas.curScore)
  local allScore = player:getUserDefaultInt(GameConstants.GameDatas.allScore)
  local gameOpenAmount = player:getUserDefaultInt(GameConstants.GameDatas.gameOpenAmount)

  -- {"玩游戏次数达到%d次","游戏单次分数达到%d分","游戏累计分数达到%d分"
  -- },


  for i,v in ipairs(GameConstants.taskData) do
    for j,k in ipairs(v) do

            local node = cc.CSLoader:createNode(taskSys.RESOURCE_FILENAME2)
            local panel=node:getChildByName("Panel_1")
            panel:getChildByName("Text_desc"):setString(string.format(GameConstants.taskList[i],k))
            panel:getChildByName("AtlasLabel_num"):setString(i)
            panel:getChildByName("AtlasLabel_num2"):setString(j)
            panel:getChildByName("Button_get"):addClickEventListener(function  (sender)
              local goldnum = GameConstants.getgold[tonumber(i)][tonumber(j)]

              print("add  gold "..goldnum)
              local GameGold = player:getUserDefaultInt(GameConstants.GameDatas.GameGold)
              print("add  gold "..GameGold)
              local allgold = tonumber(goldnum) + GameGold
              print("add  gold "..allgold)
              player:setUserDefaultInt(GameConstants.GameDatas.GameGold,allgold)
              player:setUserDefaultBool(GameConstants.GameDatas.TaskIsGet..i..j,true)

              pupWind.getInstance():pupText(self,string.format("get gold : %d",goldnum),2)
              self:newListView()
            end)
            local default_item = ccui.Layout:create()
            -- default_item:setTouchEnabled(true)
            default_item:addChild(node)
            default_item:setContentSize(panel:getContentSize())
            node:setPosition(cc.p(panel:getContentSize().width/2,panel:getContentSize().height/2))


            local isget = player:getUserDefaultBool(GameConstants.GameDatas.TaskIsGet..i..j)
            -- if isget then
            --   isget = false
            -- end
            local gamenum = 0
            if i==1 then
              gamenum = gameOpenAmount
            end
            if i==2 then
              gamenum = maxScore
            end
            if i==3 then
              gamenum = allScore
            end


              -- print("logging".."  "..gamenum..k)
              if tonumber(gamenum) > tonumber(k) then
                if isget==false then
                  panel:getChildByName("Button_get"):setTouchEnabled(true):setColor(cc.c4f(222,45,45,255))
                  self.ListView_task:insertCustomItem(default_item,0)
                    -- print("logging".."  true")
                else
                  panel:getChildByName("Button_get"):setTitleText("GetEnd"):setTouchEnabled(false):setColor(cc.c4f(45,222,45,255))
                  self.ListView_task:pushBackCustomItem(default_item)
                    -- print("logging".."  false")
                end
              else
                -- print("logging".."  ".."noget")
                panel:getChildByName("Button_get"):setTouchEnabled(false):setColor(cc.c4f(45,24,222,255))
                self.ListView_task:pushBackCustomItem(default_item)
              end
    end
  end
end

return taskSys
