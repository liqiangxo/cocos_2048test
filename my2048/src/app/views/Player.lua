cc.exports.player = class("player")

-- function new (args)
--   -- body...
-- end

player._instance = nil

function player.getInstance()
    if nil == player._instance then
        player._instance = player.new()
    end

    return player._instance
end


function player:ctor(configs)
  self.GameGold = self:getUserDefaultInt(GameConstants.GameDatas.GameGold)
  self.maxScore = self:getUserDefaultInt(GameConstants.GameDatas.maxScore)
  self.curScore = self:getUserDefaultInt(GameConstants.GameDatas.curScore)
  self.allScore = self:getUserDefaultInt(GameConstants.GameDatas.allScore)
  self.gameOpenAmount = self:getUserDefaultInt(GameConstants.GameDatas.gameOpenAmount)
  self:onCreate()
end

function player:saveAllGameData ()
    self.GameGold = self:setUserDefaultInt(GameConstants.GameDatas.GameGold,self.GameGold)
    self.maxScore = self:setUserDefaultInt(GameConstants.GameDatas.maxScore,self.maxScore)
    self.curScore = self:setUserDefaultInt(GameConstants.GameDatas.curScore,self.curScore)
    self.allScore = self:setUserDefaultInt(GameConstants.GameDatas.allScore,self.allScore)
    self.gameOpenAmount = self:setUserDefaultInt(GameConstants.GameDatas.gameOpenAmount,self.gameOpenAmount)
end

function player:setGameGold (GameGold)
  self.GameGold = GameGold
  self:setUserDefaultInt(GameConstants.GameDatas.GameGold,self.GameGold)
end
function player:setmaxScore (maxScore)
  self.maxScore = maxScore
  self:setUserDefaultInt(GameConstants.GameDatas.maxScore,self.maxScore)
end
function player:setcurScore (curScore)
  self.curScore = curScore
  self:setUserDefaultInt(GameConstants.GameDatas.curScore,self.curScore)
end
function player:setallScore (allScore)
  self.allScore = allScore
  self:setUserDefaultInt(GameConstants.GameDatas.allScore,self.allScore)
end
function player:setgameOpenAmount (gameOpenAmount)
  self.gameOpenAmount = gameOpenAmount
  self:setUserDefaultInt(GameConstants.GameDatas.gameOpenAmount,self.gameOpenAmount)
end



function player:setUserDefaultBool (str,is)
  cc.UserDefault:getInstance():setBoolForKey(str,is)
end
function player:getUserDefaultBool (is)
  return  cc.UserDefault:getInstance():getBoolForKey(is)
end
function player:setUserDefaultInt (str,num)
  cc.UserDefault:getInstance():setIntegerForKey(str,num)
end
function player:getUserDefaultInt (str)
  return  cc.UserDefault:getInstance():getIntegerForKey(str)
end
function player:setUserDefaultFloat (str,num)
  cc.UserDefault:getInstance():setFloatForKey(str,num)
end
function player:getUserDefaultFloat (str)
  return  cc.UserDefault:getInstance():getFloatForKey(str)
end

function player:isHaveTaskGet()
  for i,v in ipairs(GameConstants.taskData) do
    for j,k in ipairs(v) do

            local goldnum = GameConstants.getgold[tonumber(i)][tonumber(j)]
            local isget = player:getUserDefaultBool(GameConstants.GameDatas.TaskIsGet..i..j)
            local gamenum = 0
            if i==1 then
              gamenum = player.getInstance().gameOpenAmount
            end
            if i==2 then
              gamenum = player.getInstance().maxScore
            end
            if i==3 then
              gamenum = player.getInstance().allScore
            end
              if tonumber(gamenum) > tonumber(k) then
                if isget==false then
                    -- print("logging".."  true")
                    return  true
                end
              end
    end
  end
  return  false
end

function player:onCreate ()
  print("logging   player:onCreate")
end
