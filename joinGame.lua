local widget = require( "widget" )
local composer = require( "composer" )
local scene = composer.newScene()

local serverInfo = {}

local function connectToServer()
   local serverSocket, err = socket.connect(serverInfo.ip, serverInfo.port)

   --if serverSocket == nil then
   --   return false
   --end
   serverSocket:settimeout(0)
   serverSocket:setoption("tcp-nodelay", true)
   serverSocket:setoption("keepalive", true)
   --serverSocket:send("message")

   local info = {["serverSocket"] = serverSocket}
   local options = { params = info }
   --clientThread(serverSocket)
   composer.gotoScene( "waitGame", options)
end

---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------

-- "scene:create()"
function scene:create( event )

   local sceneGroup = self.view

   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
   serverInfo = event.params

   serverInfoLbl = display.newText("Server found: " .. serverInfo.ip .. ":" .. serverInfo.port,
                                    display.contentCenterX, 
                                    display.contentCenterY - 200,
                                    native.systemFont,
                                    28)
   sceneGroup:insert(serverInfoLbl)

   local joinGameBtn = widget.newButton
   {
    label = "button",
    onPress = connectToServer,
    emboss = false,
    --properties for a rounded rectangle button...
    shape="roundedRect",
    width = 200,
    height = 40,
    cornerRadius = 2,
    fillColor = { default={ 1, 0, 0, 1 }, over={ 1, 0.1, 0.7, 0.4 } },
    strokeColor = { default={ 1, 0.4, 0, 1 }, over={ 0.8, 0.8, 1, 1 } },
    strokeWidth = 4
   }
   joinGameBtn.x = display.contentCenterX
   joinGameBtn.y = display.contentCenterY
   joinGameBtn:setLabel( "Join Game" )
   sceneGroup:insert(joinGameBtn) 

end

-- "scene:show()"
function scene:show( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
   end
end

-- "scene:hide()"
function scene:hide( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
   end
end

-- "scene:destroy()"
function scene:destroy( event )

   local sceneGroup = self.view

   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene