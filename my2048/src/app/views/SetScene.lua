local SetScene = class("SetScene",function()
  return cc.LayerColor:create(cc.c4f(9,9,9,255),display.width,display.height)
end)
local headerlayer = require("src.app.views.headerlayer")
function SetScene:ctor ()
      local player = player.getInstance()
      self:setLocalZOrder(1000)
      -- add play button

      self.num=audio.getMusicVolume()
      local bar = cc.LayerColor:create(cc.c4f(255,23,23,255),display.width*0.6,10)
          :move(display.width*0.2,display.height*0.8)
          :setAnchorPoint(0,0.5)
          :addTo(self)
          :setScale(self.num,1)
          :setColor(cc.c4f(255*self.num,255*(1-self.num),23,255))
        local jiaButton = cc.MenuItemFont:create("add")
            :onClicked(function()
                if self.num<1.0 then
                  self.num=self.num+0.2
                  bar:setScale(self.num,1)
                  bar:setColor(cc.c4f(255*self.num,255*(1-self.num),23,255))
                  audio.setMusicVolume(self.num)

                  player:setUserDefaultFloat(GameConstants.GameSettings.MusicVolume,self.num)
                end
            end)
        local jianButton = cc.MenuItemFont:create("sub")
            :onClicked(function()
              if self.num>0.1 then
                self.num=self.num-0.2
                bar:setScale(self.num,1)
                bar:setColor(cc.c4f(255*self.num,255*(1-self.num),23,255))
                audio.setMusicVolume(self.num)
                player:setUserDefaultFloat(GameConstants.GameSettings.MusicVolume,self.num)
              end
            end)
        local MusicVolume = cc.MenuItemFont:create("MusicVolume")
          :setColor(cc.c4f(23,234,23))

        cc.Menu:create(MusicVolume,jianButton,jiaButton)
            :move(display.cx, display.height*0.7)
            :addTo(self)
            :alignItemsHorizontally()
            :alignItemsHorizontallyWithPadding(50)
            -- :alignItemsVertically()
            -- :alignItemsVerticallyWithPadding(50)





        self.num2=audio.getSoundsVolume()
        local bar2 = cc.LayerColor:create(cc.c4f(255,23,23,255),display.width*0.6,10)
            :move(display.width*0.2,display.height*0.5)
            :setAnchorPoint(0,0.5)
            :addTo(self)
            :setScale(self.num2,1)
            :setColor(cc.c4f(255*self.num2,255*(1-self.num2),23,255))

            local jiaButton2 = cc.MenuItemFont:create("add")
                :onClicked(function()
                    if self.num2<1.0 then
                      self.num2=self.num2+0.2
                      bar2:setScale(self.num2,1)
                      bar2:setColor(cc.c4f(255*self.num2,255*(1-self.num2),23,255))
                      audio.setSoundsVolume(self.num2)
                      player:setUserDefaultFloat(GameConstants.GameSettings.SoundsVolume,self.num2)
                    end
                end)
            local jianButton2 = cc.MenuItemFont:create("sub")
                :onClicked(function()
                  if self.num2>0.1 then
                    self.num2=self.num2-0.2
                    bar2:setScale(self.num2,1)
                    bar2:setColor(cc.c4f(255*self.num2,255*(1-self.num2),23,255))
                    audio.setSoundsVolume(self.num2)
                    player:setUserDefaultFloat(GameConstants.GameSettings.SoundsVolume,self.num2)
                  end
                end)
            local SoundsVolume = cc.MenuItemFont:create("SoundsVolume")
              :setColor(cc.c4f(23,234,23))
            cc.Menu:create(SoundsVolume,jianButton2,jiaButton2)
                :move(display.cx, display.height*0.4)
                :addTo(self)
                :alignItemsHorizontally()
                :alignItemsHorizontallyWithPadding(50)





    self:addChild(headerlayer.new(headType.headType_layer,self,""))
end



return SetScene
