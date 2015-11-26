-----------------------------------------------------------------------------------------
--
-- start.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local composer = require("composer")
local scene = composer.newScene()

local physics = require("physics")
physics.start()

function scene:create(event)
	local sceneGroup = self.view

	-- -- Add objects to sceneGrp to be shown in screen.
	loadBorders(sceneGroup)

	loadMap(sceneGroup)

	loadGhosts(sceneGroup)

	charactersAnimation()
end

function scene:show(event)

end

function scene:hide(event)

end

function scene:destroy(event)

end

function charactersAnimation()
	ghostRedTransitionRight()
	-- ghostBlueTransitionRight()
	-- ghostPurpleTransitionRight()
	-- ghostYellowTransitionRight()
	-- pacmanTransitionRight()
end

function ghostRedTransitionRight()
	-- TODO might be removed
	-- downTransition = transition.to(ghostBlue,{time=400, y=ghostBlue.y+20,onComplete=ghostRedTransitionLeft})
	-- downTransition = transition.to(ghostRed,{time=400, y=ghostRed.y+20,onComplete=ghostRedTransitionLeft})
	-- ghostRed
end

function ghostRedTransitionLeft()
	-- TODO might be removed
	-- upTransition = transition.to(ghostBlue,{time=400, y=ghostBlue.y-20, onComplete=ghostRedTransitionRight})
	-- upTransition = transition.to(ghostRed,{time=400, y=ghostRed.y-20, onComplete=ghostRedTransitionRight})
end

function loadGhosts(sceneGroup)
	opt =
	{
		-- Required params
		-- width = 36,
		-- height = 80,
		-- numFrames = 2,
		-- content scaling
		-- sheetContentWidth = 160,
		-- sheetContentHeight = 100,

		width = 18,
		height = 79,
		numFrames = 2,
		sheetContentWidth = 80,
		sheetContentHeight = 80,
	}

	ghostBlueSheet = graphics.newImageSheet("imgs/ghost-blue-both.png", opt)
	ghostBlue = display.newSprite( ghostBlueSheet, { name="ghostBlue", start=1, count=2, time=450 } )
	-- ghostBlueSheet = graphics.newImageSheet("imgs/gb.tps", blue_options)
	-- ghostBlue = display.newImageRect("imgs/ghost-blue-both.png", 100, 100)
	ghostBlue.anchorX = 0.5
	ghostBlue.anchorY = 1
	ghostBlue.x = display.contentCenterX - 142
	ghostBlue.y = display.contentHeight - 395
	ghostBlue:play()
	sceneGroup:insert(ghostBlue)

	ghostPurpleSheet = graphics.newImageSheet("imgs/ghost-purple-both.png", opt)
	ghostPurple = display.newSprite( ghostPurpleSheet, { name="ghostPurple", start=1, count=2, time=450 } )
	ghostPurple.anchorX = 0.5
	ghostPurple.anchorY = 1
	ghostPurple.x = display.contentCenterX + 142
	ghostPurple.y = display.contentHeight - 395
	ghostPurple:play()
	sceneGroup:insert(ghostPurple)

	ghostRedSheet = graphics.newImageSheet("imgs/ghost-red-both.png", opt)
	ghostRed = display.newSprite( ghostRedSheet, { name="ghostRed", start=1, count=2, time=450 } )
	ghostRed.anchorX = 0.5
	ghostRed.anchorY = 1
	ghostRed.x = display.contentCenterX - 142
	ghostRed.y = display.contentHeight - 52
	ghostRed:play()
	sceneGroup:insert(ghostRed)

	ghostYellowSheet = graphics.newImageSheet("imgs/ghost-yellow-both.png", opt)
	ghostYellow = display.newSprite( ghostYellowSheet, { name="ghostYellow", start=1, count=2, time=450 } )
	ghostYellow.anchorX = 0.5
	ghostYellow.anchorY = 1
	ghostYellow.x = display.contentCenterX + 142
	ghostYellow.y = display.contentHeight - 52
	ghostYellow:play()
	sceneGroup:insert(ghostYellow)
end

function loadMap(sceneGroup)
	map = display.newImageRect("imgs/div-map.png", 330, 365)
	map.anchorX = 0.5
	map.anchorY = 1
	map.x = display.contentCenterX + 3
	map.y = display.contentHeight - 113
	physics.addBody(map, "static", {density=1, bounce=0.1, friction=.2})
	sceneGroup:insert(map)
end

function loadBorders(sceneGroup)
	background = display.newImageRect("imgs/black-texture.png", 320, 480)
	background.anchorX = 0.5
	background.anchorY = 1
	background.x = display.contentCenterX
	background.y = display.contentHeight
	sceneGroup:insert(background)

	borderUp = display.newImageRect("imgs/div-border-up.png", 372, 250)
	borderUp.anchorX = 0.5
	borderUp.anchorY = 1
	borderUp.x = display.contentCenterX + 23
	borderUp.y = display.contentHeight - 239
	physics.addBody(borderUp, "static", {density=.1, bounce=0.1, friction=.2})
	sceneGroup:insert(borderUp)

	borderDown = display.newImageRect("imgs/div-border-down.png", 372, 250)
	borderDown.anchorX = 0.5
	borderDown.anchorY = 1
	borderDown.x = display.contentCenterX - 23
	borderDown.y = display.contentHeight - 95
	physics.addBody(borderDown, "static", {density=.1, bounce=0.1, friction=.2})
	sceneGroup:insert(borderDown)

	borderLeft = display.newImageRect("imgs/div-border-left.png", 372, 431)
	borderLeft.anchorX = 0.5
	borderLeft.anchorY = 1
	borderLeft.x = display.contentCenterX + 13
	borderLeft.y = display.contentHeight - 104
	physics.addBody(borderLeft, "static", {density=.1, bounce=0.1, friction=.2})
	sceneGroup:insert(borderLeft)

	borderRight = display.newImageRect("imgs/div-border-right.png", 372, 431)
	borderRight.anchorX = 0.5
	borderRight.anchorY = 1
	borderRight.x = display.contentCenterX - 13
	borderRight.y = display.contentHeight - 49
	physics.addBody(borderRight, "static", {density=.1, bounce=0.1, friction=.2})
	sceneGroup:insert(borderRight)
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene