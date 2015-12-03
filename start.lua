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

function scene:create(event)
	local sceneGroup = self.view

	-- -- Add objects to sceneGrp to be shown in screen.
	loadBorders(sceneGroup)

	loadMap(sceneGroup)

	loadGhosts(sceneGroup)

	loadPacman(sceneGroup)
	
	startControllers(getPlayerInUse())
	
	-- Runtime:addEventListener("collision", onCollision)

	-- startControllers(getCharacter())
	-- charactersAnimation()
end

function scene:show(event)
	local phase = event.phase
	if (phase == "did") then
		print("did bef col")
		Runtime:addEventListener("collision", onCollision)
		print("did")
	end
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

	local pacmanCollisionFilter = { categoryBits=2, maskBits=3 }

	pacmanSheet = graphics.newImageSheet("imgs/pacman-both.png", opt)
	pacman = display.newSprite(pacmanSheet, { name="pacman", start=1, count=2, time=450 } )
	
	pacman.anchorX = 0.5
	pacman.anchorY = 1
	pacman.x = display.contentCenterX
	pacman.y = display.contentHeight - 350
	print("pacman x = " .. pacman.x)
	print("pacman y = " .. pacman.y)
	pacman:play()
	physics.addBody(pacman, "dynamic", {friction=0, filter=pacmanCollisionFilter})
	sceneGroup:insert(pacman)

end

function loadGhosts(sceneGroup)
	fw = 18
	fh = 22

	opt =
	{
		-- Required params
		-- width = 36,
		-- height = 80,
		-- numFrames = 2,
		-- content scaling
		-- sheetContentWidth = 160,
		-- sheetContentHeight = 100,

		width = fw,
		height = fh,
		numFrames = 2,
		sheetContentWidth = fw*2,
		sheetContentHeight = fh,
	}

	ghostBlueSheet = graphics.newImageSheet("imgs/ghost-blue-both.png", opt)
	ghostBlue = display.newSprite( ghostBlueSheet, { name="ghostBlue", start=1, count=2, time=450 } )
	-- ghostBlueSheet = graphics.newImageSheet("imgs/gb.tps", blue_options)
	-- ghostBlue = display.newImageRect("imgs/ghost-blue-both.png", 100, 100)
	ghostBlue.anchorX = 0.5
	ghostBlue.anchorY = 1
	ghostBlue.x = display.contentCenterX - 145
	ghostBlue.y = display.contentHeight - 452
	ghostBlue:play()
	sceneGroup:insert(ghostBlue)

	ghostPurpleSheet = graphics.newImageSheet("imgs/ghost-purple-both.png", opt)
	ghostPurple = display.newSprite( ghostPurpleSheet, { name="ghostPurple", start=1, count=2, time=450 } )
	ghostPurple.anchorX = 0.5
	ghostPurple.anchorY = 1
	ghostPurple.x = display.contentCenterX + 145
	ghostPurple.y = display.contentHeight - 452
	ghostPurple:play()
	sceneGroup:insert(ghostPurple)

	ghostRedSheet = graphics.newImageSheet("imgs/ghost-red-both.png", opt)
	ghostRed = display.newSprite( ghostRedSheet, { name="ghostRed", start=1, count=2, time=450 } )
	ghostRed.anchorX = 0.5
	ghostRed.anchorY = 1
	ghostRed.x = display.contentCenterX - 145
	ghostRed.y = display.contentHeight - 115
	ghostRed:play()
	sceneGroup:insert(ghostRed)

	ghostYellowSheet = graphics.newImageSheet("imgs/ghost-yellow-both.png", opt)
	ghostYellow = display.newSprite( ghostYellowSheet, { name="ghostYellow", start=1, count=2, time=450 } )
	ghostYellow.anchorX = 0.5
	ghostYellow.anchorY = 1
	ghostYellow.x = display.contentCenterX + 142
	ghostYellow.y = display.contentHeight - 115
	ghostYellow:play()
	sceneGroup:insert(ghostYellow)
end

function loadMap(sceneGroup)
	-- TODO
	-- local mapCollisionFilter = { categoryBits=1, maskBits=6 }

	-- map = display.newImageRect("imgs/div-map.png", 255, 318)
	-- map.anchorX = 0.5
	-- map.anchorY = 1
	-- map.x = display.contentCenterX
	-- map.y = display.contentHeight - 134
	-- physics.addBody(map, "static", {bounce=0.8, friction=0.5})
	-- sceneGroup:insert(map)
end

function loadBorders(sceneGroup)
	local borderCollisionFilter = { categoryBits=1, maskBits=6 }

	-- background = display.newImageRect("imgs/black-texture.png", 320, 480)
	-- background.anchorX = 0.5
	-- background.anchorY = 1
	-- background.x = display.contentCenterX
	-- background.y = display.contentHeight
	-- sceneGroup:insert(background)

	borderUp = display.newImageRect("imgs/div-border-up.png", 323, 2)
	borderUp.anchorX = 0.5
	borderUp.anchorY = 1
	borderUp.x = display.contentCenterX
	borderUp.y = display.contentHeight - 478
	physics.addBody(borderUp, "static", { friction=0.5, bounce=0.3 })
	sceneGroup:insert(borderUp)

	borderDown = display.newImageRect("imgs/div-border-down.png", 323, 1)
	borderDown.anchorX = 0.5
	borderDown.anchorY = 1
	borderDown.x = display.contentCenterX
	borderDown.y = display.contentHeight - 108
	physics.addBody(borderDown, "static", { friction=0.5, bounce=0.3 })
	sceneGroup:insert(borderDown)

	borderLeft = display.newImageRect("imgs/div-border-left.png", 1, 369)
	borderLeft.anchorX = 0.5
	borderLeft.anchorY = 1
	borderLeft.x = display.contentCenterX - 159
	borderLeft.y = display.contentHeight - 109
	physics.addBody(borderLeft, "static", { friction=0.5, bounce=0.3 })
	sceneGroup:insert(borderLeft)

	borderRight = display.newImageRect("imgs/div-border-right.png", 1, 369)
	borderRight.anchorX = 0.5
	borderRight.anchorY = 1
	borderRight.x = display.contentCenterX + 159
	borderRight.y = display.contentHeight - 109
	physics.addBody(borderRight, "static", { friction=0.5, bounce=0.3 })
	sceneGroup:insert(borderRight)
end

-------------------------------------------------------------------------------------------
-- on collision of pacman
-------------------------------------------------------------------------------------------
function onCollision(event)
	print("collision")
	ghostYellow.y = ghostYellow.y + 1
	if ( event.phase == "began" ) then
		print("began collision")
		ghostYellow.x = ghostYellow.x + 1
	end
end

-------------------------------------------------------------------------------------------
-- FUNCTION TO GET PLAYER IN USE
-- TODO add real functionality
-------------------------------------------------------------------------------------------
function getPlayerInUse()
	return pacman
end

-------------------------------------------------------------------------------------------
-- EVENTS
-------------------------------------------------------------------------------------------

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )



return scene