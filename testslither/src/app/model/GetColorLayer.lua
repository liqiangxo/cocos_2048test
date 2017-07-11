local GetColorLayer = class("GetColorLayer",  function()
    return display.newNode("GetColorLayer")
end)

function GetColorLayer:ctor (data)
    self.data = data



end

function GetColorLayer:colorCall (Call)
    self.colorCallFun = Call
end
function GetColorLayer:alphaCall (Call)
    self.alphaCallFun = Call
end

function GetColorLayer:setColor (color)
    self.color = color
    if self.colorCallFun then
        self.colorCallFun()
    end
end
function GetColorLayer:setAlpha (alpha)
    self.alpha = alpha
    if self.alphaCallFun then
        self.alphaCallFun()
    end
end

return GetColorLayer
