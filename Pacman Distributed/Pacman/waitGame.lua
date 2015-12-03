local widget = require( "widget" )
local composer = require( "composer" )
local scene = composer.newScene()

local serverSocket
local character

local function sendData()
   local data, err
   print("sending data")

   data, err = serverSocket:send("hola\n")
end

local function clientThread()
   local clientTimer

   function tranlasteCharacter(player)
      if player == "1" then
         return "PACMAN"
      elseif player == "2" then
         return "GHOST BLUE"
      elseif player == "3" then
         return "GHOST PURPLE"
      elseif player == "4" then
         return "GHOST RED"
      elseif player == "5" then
         return "GHOST YELLOW"
      end
   end
   
   local function setCharacter(player)
      character = player
      local characterName = tranlasteCharacter(character)
      characterLbl.text = "You will play with " .. characterName
   end

   local function handleStart(player)
      local info = {["serverSocket"] = serverSocket, ["character"] = player}
      local options = { params = info }

      print("character " .. player)
      
      timer.cancel( clientTimer )
      composer.gotoScene( "start", options)
   end

   local function processInstruction(instruction)
      local action = instruction:sub(1,1);
      local rxcharacter = instruction:sub(2,2);

      if action == "C" then
         setCharacter(rxcharacter)
      elseif action == "S" then
         handleStart(rxcharacter)
      end
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

   clientTimer = timer.performWithDelay(200, clientFx, 0)
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

   local serverInfoLbl = display.newText("Wait for game to begin...",
                                    display.contentCenterX, 
                                    display.contentCenterY,
                                    native.systemFont,
                                    28)
   sceneGroup:insert(serverInfoLbl)

   characterLbl = display.newText("",
                                    display.contentCenterX, 
                                    display.contentCenterY-200,
                                    native.systemFont,
                                    28)
   sceneGroup:insert(characterLbl)

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
   display.remove(characterLbl)
   print("cancel clientTimer")
   timer.cancel( clientTimer )
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene