

local startScene = class("startScene", cc.load("mvc").ViewBase)
local requre = require("src.app.views.requre")
local SetScene = require("src.app.views.SetScene")

local headerlayer = require("src.app.views.headerlayer")

function startScene:onCreate()
    -- -- add background image
    -- display.newSprite("HelloWorld.png")
    --     :move(display.center)
    --     :addTo(self)
    -- add HelloWorld label
        local player = player.getInstance()

      self:addChild(headerlayer.new(headType.headType_No_return,self,""))
      self.musicname=GameConstants.GameSettings.SoundName2

      local playButton = cc.MenuItemFont:create("main")
        :setColor(cc.c4f(244,155,155,255))
          :onClicked(function()
              self:getApp():enterScene("MainScene","RANDOM",1)
          end)
      local setButton = cc.MenuItemFont:create("Settings")
        :setColor(cc.c4f(244,100,100,255))
          :onClicked(function()
              self:addChild(SetScene.new())
          end)
      cc.Menu:create(playButton,setButton)
          :move(display.cx+250, display.cy-160 )
          :addTo(self)
          :alignItemsVertically()
          :alignItemsVerticallyWithPadding(30)



    local maxScore = player:getUserDefaultInt(GameConstants.GameDatas.maxScore)
    local curScore = player:getUserDefaultInt(GameConstants.GameDatas.curScore)
    local allScore = player:getUserDefaultInt(GameConstants.GameDatas.allScore)

    cc.Label:createWithSystemFont(string.format("maxScore:%d",maxScore), "Arial", 22)
        :move(display.cx+150, display.cy)
        :setAnchorPoint(0,0.5)
        :setColor(cc.c4f(244,0,0,255))
        :addTo(self)



    cc.Label:createWithSystemFont("2048", "Arial", 50)
        :move(display.cx+230, display.cy + 200)
        :addTo(self)
    self.score=cc.Label:createWithSystemFont("Score:0","Arial",36)
        :move(display.cx+150, display.cy + 100)
        :setAnchorPoint(0,0.5)
        :addTo(self)
    self.scoreNum = 0

    for i=1,4 do
    	for j=1,4 do
    		self:addChild(requre.new("",i,j))
    	end
    end

    self.requreTable = {}
    for i=1,16 do
    	self.requreTable[i]=0
    end


    self:OneRequre()



    local  listenner = cc.EventListenerTouchOneByOne:create()
    -- 实现 onTouchBegan 事件回调函数
    listenner:registerScriptHandler(function(touch, event)
        local location = touch:getLocation()
        print("player info"..location.x .."     "..location.y)

        return true
    end, cc.Handler.EVENT_TOUCH_BEGAN )

    -- 实现 onTouchMoved 事件回调函数
    listenner:registerScriptHandler(function(touch, event)
    end, cc.Handler.EVENT_TOUCH_MOVED )

    -- 实现 onTouchEnded 事件回调函数
    listenner:registerScriptHandler(function(touch, event)

    	local x = touch:getLocation().x - touch:getStartLocation().x
    	local y = touch:getLocation().y - touch:getStartLocation().y
    	if math.abs(x) > math.abs(y)  then
    		if x>50 then
    			self:MoveAdd(1)
    		elseif x<-50 then
    			self:MoveAdd(2)
    		end
    	else

    		if y>50 then
    			self:MoveAdd(3)
    		elseif  y<-50 then
    			self:MoveAdd(4)
    		end
    	end
    end, cc.Handler.EVENT_TOUCH_ENDED )

    local eventDispatcher = self:getEventDispatcher()
    -- 添加监听器
    eventDispatcher:addEventListenerWithSceneGraphPriority(listenner, self)


    pupWind.getInstance():pupText(self,"game start",1)
end
function startScene:MoveAdd(num)
    local ismove = false
	if num==1  then
		-- print("右")
        for i=4,1,-1 do
            for j=1,4 do
                local reindex = (i-1)*4+j
                local reTab = self.requreTable[reindex]
                if reTab ~=0 then
                    local en_requre = self:getChildByTag(reindex)
                    if en_requre then
                        print("reindex  "..reindex.."  reTabg  "..reTab)
                        print("en_requre.num  "..en_requre.num.."  en_requre.x  "..en_requre.x.."  en_requre.y  "..en_requre.y)
                        if en_requre.x<4  then
                            local next_index = (en_requre.x)*4+en_requre.y
                            print("next_index   "..next_index )
                            print("self.requreTable[next_index]    "..self.requreTable[next_index])
                            if self.requreTable[next_index] ~=0 then
                                local next_requre = self:getChildByTag(next_index)
                                print("next_requre.num  "..next_requre.num .. "   en_requre.num   "..en_requre.num  )
                                if tonumber(next_requre.num) == tonumber(en_requre.num) then
                                    print("next_requre.num   "..next_requre.num )
                                    en_requre:moveToOne(num)
                                    en_requre:setNum(next_requre.num*2)
                                    self.requreTable[next_index] = next_requre.num*2
                                    self:removeChildByTag(next_index)
                                    en_requre:setTag(next_index)
                                    self.requreTable[reindex] = 0
                                    en_requre.x = en_requre.x + 1
                                    ismove = true
                                    self.scoreNum = self.scoreNum + en_requre.num
                                else
                                    print("next_requre.num  "..next_requre.num .. "   en_requre.num   "..en_requre.num  )
                                end
                            else
                                en_requre:moveToOne(num)
                                en_requre:setTag(next_index)
                                self.requreTable[reindex] = 0
                                en_requre.x = en_requre.x + 1
                                self.requreTable[next_index] = en_requre.num
                                    ismove = true
                            end
                        end
                    end
                end
            end
        end


	end
	if num==2  then
		-- print("左")
		for i=1,4 do
            for j=1,4 do
                local reindex = (i-1)*4+j
                local reTab = self.requreTable[reindex]
                if reTab ~=0 then
                    local en_requre = self:getChildByTag(reindex)
                    if en_requre then
                        print("reindex  "..reindex.."  reTabg  "..reTab)
                        print("en_requre.num  "..en_requre.num.."  en_requre.x  "..en_requre.x.."  en_requre.y  "..en_requre.y)
                        if en_requre.x>1  then
                            local next_index = (en_requre.x-2)*4+en_requre.y
                            print("next_index   "..next_index )
                            print("self.requreTable[next_index]    "..self.requreTable[next_index])
                            if self.requreTable[next_index] ~=0 then
                                local next_requre = self:getChildByTag(next_index)
                                if tonumber(next_requre.num) == tonumber(en_requre.num) then
                                    print("next_requre.num   "..next_requre.num )
                                    en_requre:moveToOne(num)
                                    en_requre:setNum(next_requre.num*2)
                                    self.requreTable[next_index] = next_requre.num*2
                                    self:removeChildByTag(next_index)
                                    en_requre:setTag(next_index)
                                    self.requreTable[reindex] = 0
                                    en_requre.x = en_requre.x - 1
                                    ismove = true
                                    self.scoreNum = self.scoreNum + en_requre.num
                                end
                            else
                                en_requre:moveToOne(num)
                                en_requre:setTag(next_index)
                                self.requreTable[reindex] = 0
                                en_requre.x = en_requre.x - 1
                                self.requreTable[next_index] = en_requre.num
                                    ismove = true
                            end
                        end
                    end
                end
            end
        end
	end
	if num==3  then
		-- print("上")
		for i=4,1,-1 do
            for j=4,1,-1 do
                local reindex = (i-1)*4+j
                local reTab = self.requreTable[reindex]
                if reTab ~=0 then
                    local en_requre = self:getChildByTag(reindex)
                    if en_requre then
                        print("reindex  "..reindex.."  reTabg  "..reTab)
                        print("en_requre.num  "..en_requre.num.."  en_requre.x  "..en_requre.x.."  en_requre.y  "..en_requre.y)
                        if en_requre.y<4  then
                            local next_index = (en_requre.x-1)*4+en_requre.y+1
                            print("next_index   "..next_index )
                            print("self.requreTable[next_index]    "..self.requreTable[next_index])
                            if self.requreTable[next_index] ~=0 then
                                local next_requre = self:getChildByTag(next_index)
                                print(type(en_requre.num))
                                print(type(next_requre.num))
                                if tonumber(next_requre.num) == tonumber(en_requre.num) then
                                    print("next_requre.num   "..next_requre.num )
                                    en_requre:moveToOne(num)
                                    en_requre:setNum(next_requre.num*2)
                                    self.requreTable[next_index] = next_requre.num*2
                                    self:removeChildByTag(next_index)
                                    en_requre:setTag(next_index)
                                    self.requreTable[reindex] = 0
                                    en_requre.y = en_requre.y + 1
                                    ismove = true
                                    self.scoreNum = self.scoreNum + en_requre.num
                                end
                            else
                                en_requre:moveToOne(num)
                                en_requre:setTag(next_index)
                                self.requreTable[reindex] = 0
                                en_requre.y = en_requre.y + 1
                                self.requreTable[next_index] = en_requre.num
                                    ismove = true
                            end
                        end
                    end
                end
            end
        end
	end
	if num==4  then
		-- print("下")
		for i=4,1,-1 do
            for j=1,4 do
                local reindex = (i-1)*4+j
                local reTab = self.requreTable[reindex]
                if reTab ~=0 then
                    local en_requre = self:getChildByTag(reindex)
                    if en_requre then
                        print("reindex  "..reindex.."  reTabg  "..reTab)
                        print("en_requre.num  "..en_requre.num.."  en_requre.x  "..en_requre.x.."  en_requre.y  "..en_requre.y)
                        if en_requre.y>1  then
                            local next_index = (en_requre.x-1)*4+en_requre.y-1
                            print("next_index   "..next_index )
                            print("self.requreTable[next_index]    "..self.requreTable[next_index])
                            if self.requreTable[next_index] ~=0 then
                                local next_requre = self:getChildByTag(next_index)
                                if tonumber(next_requre.num) == tonumber(en_requre.num) then
                                    print("next_requre.num   "..next_requre.num )
                                    en_requre:moveToOne(num)
                                    en_requre:setNum(next_requre.num*2)
                                    self.requreTable[next_index] = next_requre.num*2
                                    self:removeChildByTag(next_index)
                                    en_requre:setTag(next_index)
                                    self.requreTable[reindex] = 0
                                    en_requre.y = en_requre.y - 1
                                    ismove = true
                                    self.scoreNum = self.scoreNum + en_requre.num
                                end
                            else
                                en_requre:moveToOne(num)
                                en_requre:setTag(next_index)
                                self.requreTable[reindex] = 0
                                en_requre.y = en_requre.y - 1
                                self.requreTable[next_index] = en_requre.num
                                    ismove = true
                            end
                        end
                    end
                end
            end
        end
	end
  self.score:setString(string.format("Score:%d",self.scoreNum) )
    if ismove then
      audio.playSound(self.musicname)
        self:OneRequre()
    end
end



function startScene:OneRequre()
	math.randomseed(os.time())
    local x,y =  self:findSpace()
    if x==nil or y==nil  then
    	return
    end
	local z = math.floor(math.random(1,2))
	local s = (x-1)*4+y
	-- print(x)
	-- print(y)
	-- print(z)
    local requreone = requre.new(tonumber(z),x,y)
    requreone:setNum(z)
    self:addChild(requreone,2,s)
    self.requreTable[s]=z
end

-- function startScene:onTouch(event, x, y)

--     if event == "began" then
--         print("player info"..x.."     "..y)
--     elseif event == "ended" then

--     end
--     return true
-- end

function startScene:findSpace()
	math.randomseed(os.time())
	local x = 0
	for i,v in ipairs(self.requreTable) do
		if v == 0 then
			x  =  x + 1
		end
	end
	if x > 1 then
		local z = math.floor(math.random(1,x))


		-- print(x.."剩余空格".."   ".."随机"..z)

		for i=4,1,-1 do
			for j=4,1,-1 do
				-- print(i.."  i  j  "..j)
				local n = (i-1)*4+j
				if self.requreTable[n] == 0 then
					if x == z then
						return i,j
					end

					x = x - 1
				end
			end
		end



	else
    local maxScore = player:getUserDefaultInt(GameConstants.GameDatas.maxScore)
    local gameOpenAmount = player:getUserDefaultInt(GameConstants.GameDatas.gameOpenAmount)
    local allScore = player:getUserDefaultInt(GameConstants.GameDatas.allScore)
    gameOpenAmount = gameOpenAmount + 1
    player:setUserDefaultInt(GameConstants.GameDatas.allScore,self.scoreNum+allScore)
    player:setUserDefaultInt(GameConstants.GameDatas.gameOpenAmount,gameOpenAmount)
    self:getApp():enterScene("GameOver")


    if maxScore<self.scoreNum then
      player:setUserDefaultInt(GameConstants.GameDatas.maxScore,self.scoreNum)
    end


	end


end







return startScene
