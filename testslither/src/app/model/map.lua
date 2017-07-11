local map = class("map",  function()
    return display.newNode("map")
end)

function map:ctor (data)
    self.data = data

    self.mapLayer = display.newNode()
    self:addChild(self.mapLayer)

    local c = cc.DrawNode:create();
    if #self.data.color==4 then
        c:drawCircle(cc.p(0,0),data.radius,0,360,false,self.data.color )
    else
        c:drawCircle(cc.p(0,0),data.radius,0,360,false,ccc4FFromccc3B(self.data.color) )
    end
    self.mapLayer:addChild(c)

end

return map
