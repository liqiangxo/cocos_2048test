cc.exports.SceneManager = class("SceneManager")

SceneManager._instance = nil

cc.exports.SceneTable = {}

function SceneManager.getInstance ()
  if nil == SceneManager._instance then
    SceneManager._instance =  SceneManager.new()
  end
  return SceneManager._instance
end

function SceneManager:ctor ()
  SceneTable = {}
  self._loadingScene = nil
end



function SceneManager:getRunningScene ()
  return cc.Director:getInstance():getRunningScene()
end




function SceneManager:gotoScene (sender, sceneName)
  self._loadingScene = scene
  self._sceneNema = sceneName
  sender:getApp():enterScene(sceneName)
end
