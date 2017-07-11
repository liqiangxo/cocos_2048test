local CircleBase = class("CircleBase",  function()
    return display.newNode("CircleBase")
end)

-- cc.RED = cc.c3b(255,0,0)
-- cc.GREEN = cc.c3b(0,255,0)
-- cc.BLUE = cc.c3b(0,0,255)
-- cc.BLACK = cc.c3b(0,0,0)
-- cc.WHITE = cc.c3b(255,255,255)
-- cc.YELLOW = cc.c3b(255,255,0)
function CircleBase:ctor (data)
    self.data = data
    local c = cc.DrawNode:create();
    if #self.data.color==4 then
        c:drawSolidCircle(cc.p(0,0),data.radius,0,8,self.data.color )
    else
        c:drawSolidCircle(cc.p(0,0),data.radius,0,8,ccc4FFromccc3B(self.data.color) )
    end
    self:addChild(c)
end

return CircleBase
