local requre = class("requre",function()
    local layer = cc.LayerColor:create(cc.c4f(32, 32, 32, 255),gameconfig.requre_width,gameconfig.requre_height)
    return layer
end)

function requre:ctor(num,x,y)
	-- body
    self.x=x
    self.y=y
    self.num = num
    self.allspacing = gameconfig.requre_width+gameconfig.spacing
    self:setPosition(gameconfig.requre_x + self.x * self.allspacing,gameconfig.requre_y + self.y * self.allspacing)
	  self.lab=cc.Label:createWithSystemFont(self.num,"",44)
    self.lab:setPosition(55,55)
    self:addChild(self.lab)
    self:setScale(0.1)
    local ac1 = cc.ScaleTo:create(0.1,1.1)
    local ac2 = cc.ScaleTo:create(0.1,1)
    self:runAction(cc.Sequence:create(ac1,ac2))
    -- self:setNum(tonumber(num))

end

function requre:getNum()
	return self.num
end
function requre:setNum(num)
	self.num = num
	self.lab:setString(self.num)

	self.lab:setColor(colortableText[tostring(self.num)])
	self:setColor(colortable[tostring(self.num)])
end

function requre:removeziji()
	self.removeFromParent()
end

function requre:moveToOne(num)
	if num==1  then
		print("右")
		if self.x<4 then
			self:runAction(cc.MoveTo:create(0.2, cc.p(gameconfig.requre_x+(self.x+1)*self.allspacing,gameconfig.requre_y+self.y*self.allspacing)))
		end

	end
	if num==2  then
		print("左")

		if self.x>1 then
			self:runAction(cc.MoveTo:create(0.2, cc.p(gameconfig.requre_x+(self.x-1)*self.allspacing,gameconfig.requre_y+self.y*self.allspacing)))
		end
	end
	if num==3  then
		print("上")

		if self.y<4 then
			self:runAction(cc.MoveTo:create(0.2, cc.p(gameconfig.requre_x+self.x*self.allspacing,gameconfig.requre_y+(self.y+1)*self.allspacing)))
		end
	end
	if num==4  then
		print("下")

		if self.y>1 then
			self:runAction(cc.MoveTo:create(0.2, cc.p(gameconfig.requre_x+self.x*self.allspacing,gameconfig.requre_y+(self.y-1)*self.allspacing)))
		end
	end
end


return requre
