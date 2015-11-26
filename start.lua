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
	-- downTransition = transition.to(ghostBlue,{time=400, y=ghostBlue.y+20,onComplete=ghostRedTransitionLeft})
	-- downTransition = transition.to(ghostRed,{time=400, y=ghostRed.y+20,onComplete=ghostRedTransitionLeft})
	-- ghostRed
end

function ghostRedTransitionLeft()
	-- upTransition = transition.to(ghostBlue,{time=400, y=ghostBlue.y-20, onComplete=ghostRedTransitionRight})
	-- upTransition = transition.to(ghostRed,{time=400, y=ghostRed.y-20, onComplete=ghostRedTransitionRight})
end

function loadGhosts(sceneGroup)
	blue_options =
	{
		-- Required params
		width = 80,
		height = 100,
		numFrames = 2,
		-- content scaling
		sheetContentWidth = 160,
		sheetContentHeight = 100,
	}

	ghostBlueSheet = graphics.newImageSheet("imgs/ghost-blue.png", blue_options)
	-- ghostBlueSheet = graphics.newImageSheet("imgs/gb.tps", blue_options)
	ghostBlue = display.newSprite( ghostBlueSheet, { name="ghostBlue", start=1, count=2, time=500 } )
	-- ghostBlue = display.newImageRect("imgs/ghost-blue-both.png", 100, 100)
	ghostBlue.anchorX = 0.5
	ghostBlue.anchorY = 1
	ghostBlue.x = display.contentCenterX - 125
	ghostBlue.y = display.contentHeight - 392
	-- ghostBlue:play()
	sceneGroup:insert(ghostBlue)

	ghostPurple = display.newImageRect("imgs/ghost-purple.png", 100, 100)
	ghostPurple.anchorX = 0.5
	ghostPurple.anchorY = 1
	ghostPurple.x = display.contentCenterX + 155
	ghostPurple.y = display.contentHeight - 392
	sceneGroup:insert(ghostPurple)

	ghostRed = display.newImageRect("imgs/ghost-red.png", 100, 100)
	ghostRed.anchorX = 0.5
	ghostRed.anchorY = 1
	ghostRed.x = display.contentCenterX - 125
	ghostRed.y = display.contentHeight - 53
	sceneGroup:insert(ghostRed)

	ghostYellow = display.newImageRect("imgs/ghost-yellow.png", 100, 100)
	ghostYellow.anchorX = 0.5
	ghostYellow.anchorY = 1
	ghostYellow.x = display.contentCenterX + 155
	ghostYellow.y = display.contentHeight - 53
	sceneGroup:insert(ghostYellow)
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