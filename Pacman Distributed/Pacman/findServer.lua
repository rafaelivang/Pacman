local widget = require( "widget" )
local composer = require( "composer" )
local scene = composer.newScene()
local socket = require("socket")

local DISCOVER_MSG = "JOIN_GAME"
local serverInfo = {}
local PORT = 2222
local TCP_PORT = 3333

local getMyIP = function()
    local s = socket.udp()
    s:setpeername( "74.125.115.104", 80 )
    local ip = s:getsockname()
    print("My IP: ", ip)
    return ip
end

local function listenServer( button )
    print("Enter to listenServer function")

    -- try multicast
    --local listenSocket = socket.udp()
    --listenSocket:setsockname( "224.0.0.1", PORT )

    --local name = listenSocket:getsockname()
    --if ( name ) then 
    --    listenSocket:setoption( "ip-add-membership", { multiaddr="224.0.0.1", interface = getMyIP() } )
    --else
        -- try broadcast
        --listenSocket:close()
        local listenSocket = socket.udp()
        listenSocket:setsockname( "*", PORT ) 
    --end

    listenSocket:settimeout( 0 ) 

    local stop

    local count = 0
    local listenTimer 
    local function listen()
        repeat
            local data, ip, port = listenSocket:receivefrom()
            --print( "data: ", data, "IP: ", ip, "port: ", port )
            if data and data == DISCOVER_MSG then
                    local info = { ["ip"]=ip, ["port"]=TCP_PORT }
                    serverInfo = info
                    timer.cancel( listenTimer )
                    listenSocket:close()
                    print( "Server found: ", ip, TCP_PORT )
                    local options = { params = info }
                    composer.gotoScene( "joinGame", options)
                    do return end
            end
        until not data

         --make sure to close socket
         count = count + 1
         if count >= 20 then
            listenSocket:close()
            print("Server not found")
         end
     end
   
     -- timer 100ms for 20 times 
   listenTimer = timer.performWithDelay( 100, listen, 20 )
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

   local serchServerButton = widget.newButton
   {
    label = "button",
    onPress = listenServer,
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
   serchServerButton.x = display.contentCenterX
   serchServerButton.y = display.contentCenterY
   serchServerButton:setLabel( "Search server" )
   sceneGroup:insert(serchServerButton)

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
   --display.remove(serchServerButton)
   --print("destroy")
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene