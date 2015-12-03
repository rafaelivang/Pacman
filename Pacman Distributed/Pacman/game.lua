--[[local widget = require( "widget" )
local composer = require( "composer" )
local scene = composer.newScene()

local serverSocket
local character
local gameLbl

local function sendData(msg)
   local data, err

   print("Send: " .. msg)
   data, err = serverSocket:send(msg)
end

local function sendUpMsg()
   local data, err

   sendData("U"..character.."\n")
end

local function sendDownMsg()
   local data, err

   sendData("D"..character.."\n")
end

local function clientThread()

   local function processInstruction(instruction)
      local action = instruction:sub(1,1);
      local character = instruction:sub(2,2);

      --TODO implement movement of character
      print("Received: " .. instruction)
      gameLbl.text = instruction
   end

   local function clientFx()
      local data, err
      local allData = {}
      local socketsArray = {serverSocket}

      local canread = socket.select(socketsArray,nil,0)

      for _,server in ipairs(canread) do
         local line, err = server:receive("*l")
         if not err then
            processInstruction(line)
         else
            print(err)
         end
      end
   end

   clientTimer = timer.performWithDelay(5, clientFx, 0)
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
   serverSocket = event.params.serverSocket
   character = event.params.character

   gameLbl = display.newText("Game",
                                    display.contentCenterX, 
                                    display.contentCenterY,
                                    native.systemFont,
                                    28)
   sceneGroup:insert(gameLbl)

   local upBtn = widget.newButton
   {
    label = "button",
    onPress = sendUpMsg,
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
   upBtn.x = display.contentCenterX
   upBtn.y = display.contentCenterY + 100
   upBtn:setLabel( "up" )
   sceneGroup:insert(upBtn) 

   local downBtn = widget.newButton
   {
    label = "button",
    onPress = sendDownMsg,
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
   downBtn.x = display.contentCenterX
   downBtn.y = display.contentCenterY + 150
   downBtn:setLabel( "down" )
   sceneGroup:insert(downBtn) 

   clientThread()
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

return scene]]--