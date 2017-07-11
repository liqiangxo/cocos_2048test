local headerlayer = class("headerlayer",function  ()
  return cc.Node:create()
end)

function headerlayer:ctor (type,sender,scenename)
  local node = cc.CSLoader:createNode("headerlayer.csb")
  local panel = node:getChildByName("Panel_1")
  node:setPosition(0,display.height)
  node:runAction(cc.MoveTo:create(0.5,cc.p(0,display.height-panel:getContentSize().height)))

  local Button_return = panel:getChildByName("Button_return")
  if type==headType.headType_No_return then
    Button_return:setVisible(false)
  else
    Button_return:addClickEventListener(function  (sen)
      if type == headType.headType_scene then
        self:runAction(cc.Sequence:create(cc.MoveTo:create(0.5,cc.p(0,display.height))  ,  cc.CallFunc:create(function  ()
          sender:getApp():enterScene(scenename,"RANDOM")
        end)))
      else
        self:runAction(cc.Sequence:create(cc.MoveTo:create(0.5,cc.p(0,display.height))  ,  cc.CallFunc:create(function  ()
          sender:removeFromParentAndCleanup(true)
        end)))
      end
    end)
    Button_return:setVisible(true)
  end

  local maxScore = player:getUserDefaultInt(GameConstants.GameDatas.maxScore)
  local curScore = player:getUserDefaultInt(GameConstants.GameDatas.curScore)
  local allScore = player:getUserDefaultInt(GameConstants.GameDatas.allScore)
  local gameOpenAmount = player:getUserDefaultInt(GameConstants.GameDatas.gameOpenAmount)
  local GameGold = player:getUserDefaultInt(GameConstants.GameDatas.GameGold)

  self.amount = panel:getChildByName("AtlasLabel_amount")
  self.allscore = panel:getChildByName("AtlasLabel_allscore")
  self.maxscore = panel:getChildByName("AtlasLabel_maxscore")
  self.gold = panel:getChildByName("AtlasLabel_gold")
  self.amount:setString(gameOpenAmount)
  self.maxscore:setString(maxScore)
  self.allscore:setString(allScore)
  self.gold:setString(GameGold)


  self:addChild(node)
end

return headerlayer
