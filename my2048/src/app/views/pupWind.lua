cc.exports.pupWind = class("pupWind")


pupWind._instance = nil

function pupWind.getInstance()
    if nil == pupWind._instance then
        pupWind._instance = pupWind.new()
    end

    return pupWind._instance
end


function pupWind:pupText (sender,str,type)
  if type == 1 then
    local node = cc.Node:create()
    :move(cc.p(display.cx,-display.cy/6.4))

    local strlabel = cc.Label:createWithSystemFont(str,"Arial",40)
    node:addChild(strlabel)
    local runscene = cc.Director:getInstance():getRunningScene()
    runscene:addChild(node)


    local action1 = cc.MoveTo:create(0.4,cc.p(display.cx,display.cy))

    local action2 = cc.ScaleTo:create(0.4,1.3)

    local action3 = cc.DelayTime:create(0.8)

    local action4 = cc.MoveTo:create(0.5,cc.p(display.width*1.30,display.cy))

    node:runAction(cc.Sequence:create(cc.Spawn:create(action1,action2),action3,action4,cc.RemoveSelf:create(true)))
  end

    if type == 2 then
      local node = cc.LayerColor:create(cc.c4f(200,50,50,200),display.width/2,display.height/12)
      :setScale(1,0)

      node:setPosition(cc.p(display.cx-node:getContentSize().width/2,display.cy-node:getContentSize().height/2))

      local strlabel = cc.Label:createWithSystemFont(str,"Arial",40)
      :move(cc.p(node:getContentSize().width/2,node:getContentSize().height/2))
      node:addChild(strlabel)

      local runscene = cc.Director:getInstance():getRunningScene()
      runscene:addChild(node)



      local action1 = cc.ScaleTo:create(0.4,1)

      local action3 = cc.DelayTime:create(0.8)

      local action4 = cc.MoveTo:create(0.5,cc.p(display.width+200,display.cy-node:getContentSize().height/2))

      node:runAction(cc.Sequence:create(action1,action3,action4,cc.RemoveSelf:create(true)))
    end
end
