local backpack = class("backpack",cc.load("mvc").ViewBase)
local headerlayer = require("src.app.views.headerlayer")
-- -- 加载csb文件
backpack.RESOURCE_FILENAME = "backpackscene.csb"

-- 获取UI控件
backpack.RESOURCE_BINDING = {
    ["ListView_backpack"]   = {["varname"] = "ListView_backpack"},
    ["Button_return"] = {["varname"] = "Button_return"},
    ["Panel_common"] = {["varname"] = "Panel_common"},
    ["Panel_randomgoods"] = {["varname"] = "Panel_randomgoods"}
}


function backpack:onCreate ()
    -- 按钮使用
    self.Button_return:addClickEventListener(function(sender)
        self:getApp():enterScene("MainScene")
    end)
    self:newListView()
    self:addChild(headerlayer.new(headType.headType_scene,self,"MainScene"))
end

function backpack:newListView ()
  --初始化随机商品
  local player = player.getInstance()
  self.ListView_backpack:removeAllItems()
  local maxScore = player:getUserDefaultInt(GameConstants.GameDatas.maxScore)
  local curScore = player:getUserDefaultInt(GameConstants.GameDatas.curScore)
  local allScore = player:getUserDefaultInt(GameConstants.GameDatas.allScore)
  local gameOpenAmount = player:getUserDefaultInt(GameConstants.GameDatas.gameOpenAmount)

  self.Button_return:setVisible(false)
  local node = cc.CSLoader:createNode("onetiao.csb")
  local panel=node:getChildByName("Panel_bp")
  local x = 1
  for k,v in pairs(shopgoods.goods1) do

      local oneItem = cc.CSLoader:createNode("oneItem.csb")
      local panel1=oneItem:getChildByName("Panel_item")
      local Panel_desc=panel1:getChildByName("Panel_desc")
      local Text_desc=Panel_desc:getChildByName("Text_desc")
      local Text_goldnum=panel1:getChildByName("Text_goldnum")
      local Button_backpack=panel1:getChildByName("Button_backpack")
      local Text_itemname=panel1:getChildByName("Text_itemname")
      Button_backpack:addClickEventListener(function  (sender)
        print("logging"..b.name)
      end)
      Text_itemname:setString(b.name)
      Text_goldnum:setString(b.gold)
      Text_desc:setString(b.desc)
      panel:addChild(oneItem)
      oneItem:setPosition(cc.p(panel:getContentSize().width/4*y,panel:getContentSize().height/2))
    x = x + 1
  end


  local default_item = ccui.Layout:create()
  -- default_item:setTouchEnabled(true)
  default_item:addChild(node)
  default_item:setContentSize(panel:getContentSize())
  node:setPosition(cc.p(panel:getContentSize().width/2,panel:getContentSize().height/2))

  self.Panel_randomgoods:addChild(default_item)







  for k,v in pairs(shopgoods) do

    local node = cc.CSLoader:createNode("onetiao.csb")
    local panel=node:getChildByName("Panel_bp")

    local y = 1
    for p,b in pairs(v) do
      local oneItem = cc.CSLoader:createNode("oneItem.csb")
      local panel1=oneItem:getChildByName("Panel_item")
      local Panel_desc=panel1:getChildByName("Panel_desc")
      local Text_desc=Panel_desc:getChildByName("Text_desc")
      local Text_goldnum=panel1:getChildByName("Text_goldnum")
      local Button_backpack=panel1:getChildByName("Button_backpack")
      local Text_itemname=panel1:getChildByName("Text_itemname")
      Button_backpack:addClickEventListener(function  (sender)
        print("logging"..b.name)
      end)
      Text_itemname:setString(b.name)
      Text_goldnum:setString(b.gold)
      Text_desc:setString(b.desc)
      panel:addChild(oneItem)
      oneItem:setPosition(cc.p(panel:getContentSize().width/4*y,panel:getContentSize().height/2))
      y = y + 1
    end


    local default_item = ccui.Layout:create()
    -- default_item:setTouchEnabled(true)
    default_item:addChild(node)
    default_item:setContentSize(panel:getContentSize())
    node:setPosition(cc.p(panel:getContentSize().width/2,panel:getContentSize().height/2))

    self.ListView_backpack:pushBackCustomItem(default_item)
  end


end


return backpack
