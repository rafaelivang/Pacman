-----------------------------------------------------------------------------------------
--
-- start.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local composer = require("composer")
local scene = composer.newScene()

local physics = require("physics")

-- local widget = require("widget")
local controller = require("controller")
physics.start()
physics.setGravity(0,0)

local serverSocket
local character

local function clientThread()

   local function processInstruction(instruction)
      local action = instruction:sub(1,1);
      local rxplayer = instruction:sub(2,2);

      if action ~= nil and action ~= '' and character ~= nil and character ~= '' then
      	if action == "U" then
      		movePlayerUp(getPlayer(rxplayer))
      	elseif action == "D" then
      		movePlayerDown(getPlayer(rxplayer))
      	elseif action == "R" then
      		movePlayerRight(getPlayer(rxplayer))
      	elseif action == "L" then
      		movePlayerLeft(getPlayer(rxplayer))
      	end
      end

      --TODO implement movement of character
      print("Received: " .. instruction)
      --gameLbl.text = instruction
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

function scene:create(event)
	local sceneGroup = self.view

	serverSocket = event.params.serverSocket
    character = event.params.character

	-- -- Add objects to sceneGrp to be shown in screen.
	loadBorders(sceneGroup)

	loadMap(sceneGroup)

	loadGhosts(sceneGroup)

	loadPacman(sceneGroup)

	loadPoints(sceneGroup)
	
	startControllers(getPlayerInUse(), character, serverSocket)

	clientThread()
end

function scene:show(event)
	
end

function scene:hide(event)

end

function scene:destroy(event)

end

-- function ch:getCharacter()
-- 	ch = pacman
-- 	return ch
-- end

function loadPacman(sceneGroup)
	w = 18
	h = 22

	opt =
	{
		width = w,
		height = h,
		numFrames = 2,
		sheetContentWidth = w*2,
		sheetContentHeight = h,
	}

	local pacmanCollisionFilter = { categoryBits=2, maskBits=13 }

	pacmanSheet = graphics.newImageSheet("imgs/pacman-both.png", opt)
	pacman = display.newSprite(pacmanSheet, { name="pacman", start=1, count=2, time=450 } )
	pacman.class = "pacman"
	pacman.anchorX = 0.5
	pacman.anchorY = 1
	pacman.x = display.contentCenterX
	pacman.y = display.contentHeight - 255
	pacman:play()
	physics.addBody(pacman, {friction=0, filter=pacmanCollisionFilter})
	sceneGroup:insert(pacman)

end

function loadGhosts(sceneGroup)
	fw = 18
	fh = 22

	opt =
	{
		width = fw,
		height = fh,
		numFrames = 2,
		sheetContentWidth = fw*2,
		sheetContentHeight = fh,
	}
	local ghostCollisionFilter = { categoryBits=4, maskBits=3 }

	ghostBlueSheet = graphics.newImageSheet("imgs/ghost-blue-both.png", opt)
	ghostBlue = display.newSprite( ghostBlueSheet, { name="ghostBlue", start=1, count=2, time=450 } )
	ghostBlue.class = "ghost"
	ghostBlue.anchorX = 0.5
	ghostBlue.anchorY = 1
	ghostBlue.x = display.contentCenterX - 145
	ghostBlue.y = display.contentHeight - 452
	ghostBlue:play()
	physics.addBody(ghostBlue, {friction=0, filter=ghostCollisionFilter})
	sceneGroup:insert(ghostBlue)

	ghostPurpleSheet = graphics.newImageSheet("imgs/ghost-purple-both.png", opt)
	ghostPurple = display.newSprite( ghostPurpleSheet, { name="ghostPurple", start=1, count=2, time=450 } )
	ghostPurple.class = "ghost"
	ghostPurple.anchorX = 0.5
	ghostPurple.anchorY = 1
	ghostPurple.x = display.contentCenterX + 145
	ghostPurple.y = display.contentHeight - 452
	ghostPurple:play()
	physics.addBody(ghostPurple, {friction=0, filter=ghostCollisionFilter})
	sceneGroup:insert(ghostPurple)

	ghostRedSheet = graphics.newImageSheet("imgs/ghost-red-both.png", opt)
	ghostRed = display.newSprite( ghostRedSheet, { name="ghostRed", start=1, count=2, time=450 } )
	ghostRed.class = "ghost"
	ghostRed.anchorX = 0.5
	ghostRed.anchorY = 1
	ghostRed.x = display.contentCenterX - 145
	ghostRed.y = display.contentHeight - 115
	ghostRed:play()
	physics.addBody(ghostRed, {friction=0, filter=ghostCollisionFilter})
	sceneGroup:insert(ghostRed)

	ghostYellowSheet = graphics.newImageSheet("imgs/ghost-yellow-both.png", opt)
	ghostYellow = display.newSprite( ghostYellowSheet, { name="ghostYellow", start=1, count=2, time=450 } )
	ghostYellow.class = "ghost"
	ghostYellow.anchorX = 0.5
	ghostYellow.anchorY = 1
	ghostYellow.x = display.contentCenterX + 142
	ghostYellow.y = display.contentHeight - 115
	ghostYellow:play()
	physics.addBody(ghostYellow, {friction=0, filter=ghostCollisionFilter})
	sceneGroup:insert(ghostYellow)
end

function loadPoints(sceneGroup)
	local pointCollisionFilter = { categoryBits=8, maskBits=3 }
	points = {}
	
	local yPos = 457
	local yAddition = 32
	local iPos = 0

	for i=1,11 do
		local xPos = 143
		local iBlocks = 1
		for j=1,13 do
			if ((i == 1 and j==1) or (i == 1 and j== 13) or (i==7 and j==6) or (i==7 and j==7) or
				(i == 11 and j==1) or (i == 11 and j== 13)) then
				xPos = xPos - 24
			elseif (i % 2 == 0 and (j ~= iBlocks)) then
				xPos = xPos - 24
			else
				tmpPoint = display.newImageRect("imgs/point.png", 10, 10)
				tmpPoint.class = "point"
				tmpPoint.anchorX = 0.5
				tmpPoint.anchorY = 1
				tmpPoint.x = display.contentCenterX - xPos
				tmpPoint.y = display.contentHeight - yPos
				tmpPoint.arrayPosition = iPos -- POSITION in the array
				physics.addBody(tmpPoint, { friction=0.5, filter=pointCollisionFilter })
				sceneGroup:insert(tmpPoint)
				points[iPos] = tmpPoint
				iPos = iPos + 1
				xPos = xPos - 24
				iBlocks = iBlocks + 4
			end
		end
		-- yPos = yPos - yAddition
		if (i == 3) then
			yAddition = yAddition + 1
			yPos = yPos - yAddition
		elseif (i == 10) then
			yAddition = yAddition + 2
			yPos = yPos - yAddition
		else
			yPos = yPos - yAddition
		end
	end
end

function loadMap(sceneGroup)
	local mapCollisionFilter = { categoryBits=1, maskBits=14 }
	blockMap = {}

	local yPos = 410
	local iPos = 0
	for j=1,5 do
		local xPos = 100
		for i=1,3 do
			tmpBlock = display.newImageRect("imgs/div-block.png", 65, 37)
			tmpBlock.class = "map"
			tmpBlock.anchorX = 0.5
			tmpBlock.anchorY = 1
			tmpBlock.x = display.contentCenterX - xPos
			tmpBlock.y = display.contentHeight - yPos
			physics.addBody(tmpBlock, "static", { friction=0.5, filter=mapCollisionFilter })
			sceneGroup:insert(tmpBlock)
			blockMap[iPos] = tmpBlock
			iPos = iPos + 1
			xPos = xPos - 100
		end
		yPos = yPos - 65
	end
end

function loadBorders(sceneGroup)
	local borderCollisionFilter = { categoryBits=1, maskBits=14 }

	borderUp = display.newImageRect("imgs/div-border-up.png", 323, 2)
	borderUp.class = "border"
	borderUp.anchorX = 0.5
	borderUp.anchorY = 1
	borderUp.x = display.contentCenterX
	borderUp.y = display.contentHeight - 478
	physics.addBody(borderUp, "static", { friction=0.5, filter=borderCollisionFilter })
	sceneGroup:insert(borderUp)

	borderDown = display.newImageRect("imgs/div-border-down.png", 323, 1)
	borderDown.class = "border"
	borderDown.anchorX = 0.5
	borderDown.anchorY = 1
	borderDown.x = display.contentCenterX
	borderDown.y = display.contentHeight - 108
	physics.addBody(borderDown, "static", { friction=0.5, filter=borderCollisionFilter })
	sceneGroup:insert(borderDown)

	borderLeft = display.newImageRect("imgs/div-border-left.png", 1, 369)
	borderLeft.class = "border"
	borderLeft.anchorX = 0.5
	borderLeft.anchorY = 1
	borderLeft.x = display.contentCenterX - 159
	borderLeft.y = display.contentHeight - 109
	physics.addBody(borderLeft, "static", { friction=0.5, filter=borderCollisionFilter })
	sceneGroup:insert(borderLeft)

	borderRight = display.newImageRect("imgs/div-border-right.png", 1, 369)
	borderRight.class = "border"
	borderRight.anchorX = 0.5
	borderRight.anchorY = 1
	borderRight.x = display.contentCenterX + 159
	borderRight.y = display.contentHeight - 109
	physics.addBody(borderRight, "static", { friction=0.5, filter=borderCollisionFilter })
	sceneGroup:insert(borderRight)
end

-------------------------------------------------------------------------------------------
-- on collision of pacman
-------------------------------------------------------------------------------------------
local function onGlobalCollision(event)
	if ( event.phase == "began" ) then
		if (event.object2.class == "point") then
			print(event.object2.arrayPosition)
			event.object2:removeSelf()
		end
		if (event.object2.class == "pacman" and event.object1.class == "ghost") then
			if (event.object2.class == "pacman") then
				event.object2:removeSelf()
				composer.gotoScene( "gameover" )
			end
		elseif (event.object1.class == "pacman" and event.object2.class == "ghost") then
				event.object1.class:removeSelf()
				composer.gotoScene( "gameover" )
		end
	end
end
Runtime:addEventListener("collision", onGlobalCollision)

function getPlayer(pid)
	if pid == "1" then
         return pacman
      elseif pid == "2" then
         return ghostBlue
      elseif pid == "3" then
         return ghostPurple
      elseif pid == "4" then
         return ghostRed
      elseif pid == "5" then
         return ghostYellow
      end
end

-------------------------------------------------------------------------------------------
-- FUNCTION TO GET PLAYER IN USE
-- TODO add real functionality
-------------------------------------------------------------------------------------------
function getPlayerInUse()
	return getPlayer(character)
end

-------------------------------------------------------------------------------------------
-- EVENTS
-------------------------------------------------------------------------------------------

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )



return scene