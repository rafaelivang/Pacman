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
	background = display.newImageRect("imgs/black-texture.png", 320, 480)
	background.anchorX = 0.5
	background.anchorY = 1
	background.x = display.contentCenterX
	background.y = display.contentHeight
	sceneGroup:insert(background)

end

function scene:show(event)

end

function scene:hide(event)

end

function scene:destroy(event)

end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene