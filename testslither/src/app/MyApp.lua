
local MyApp = class("MyApp", cc.load("mvc").AppBase)
function MyApp:onCreate()
    math.randomseed(os.time())
    cc.Director:getInstance():getConsole():listenOnTCP(5678)
end

return MyApp
