-- 
-- Abstract: Bouncing fruit, using enterFrame listener for animation
-- 
-- Version: 1.3 (uses new viewableContentHeight, viewableContentWidth properties)
-- 
-- Sample code is MIT licensed, see https://www.coronalabs.com/links/code/license
-- Copyright (C) 2010 Corona Labs Inc. All Rights Reserved.

-- Demonstrates a simple way to perform animation, using an "enterFrame" listener to trigger updates.
--
-- Supports Graphics 2.0
------------------------------------------------------------


local widget = require( "widget" )
local screenBottom = display.viewableContentHeight + display.screenOriginY
local speed = 5

-------------------------------------------------------------------------------------------
-- BUTTONS
-------------------------------------------------------------------------------------------
local buttonRadius = 20

-- Function to handle button events
local function handleButtonUpEvent(event)
	local data, err
 
   	data, err = serverSocket:send("U"..playerId.."\n")
end

-- Function to handle button events
local function handleButtonDownEvent( event )
	local data, err
 
   	data, err = serverSocket:send("D"..playerId.."\n")
end

-- Function to handle button events
local function handleButtonRightEvent( event )
	local data, err
 
   	data, err = serverSocket:send("R"..playerId.."\n")
end

-- Function to handle button events
local function handleButtonLeftEvent( event )
	local data, err
 
   	data, err = serverSocket:send("L"..playerId.."\n")
end

-- Function to handle button events
function movePlayerUp( player )
	player.y = player.y-speed
end

-- Function to handle button events
function movePlayerDown( player )
	player.y = player.y+speed
end

-- Function to handle button events
function movePlayerRight( player )
	player.x = player.x+speed
end

-- Function to handle button events
function movePlayerLeft( player )
	player.x = player.x-speed
end

-- Create the widget
local buttonLeft = widget.newButton
{
    label = "buttonLeft",
    onPress = handleButtonLeftEvent,
    emboss = false,
    --properties for a rounded rectangle button...
    shape="circle",
	radius=buttonRadius,
    fillColor = { default={ 1, 0, 0, 1 }, over={ 1, 0.1, 0.7, 0.4 } },
    strokeColor = { default={ 1, 0.4, 0, 1 }, over={ 0.8, 0.8, 1, 1 } },
    strokeWidth = 4
}

-- Create the widget
local buttonRight = widget.newButton
{
    label = "buttonRight",
    onPress = handleButtonRightEvent,
    emboss = false,
    --properties for a rounded rectangle button...
    shape="circle",
	radius=buttonRadius,
    fillColor = { default={ 1, 0, 0, 1 }, over={ 1, 0.1, 0.7, 0.4 } },
    strokeColor = { default={ 1, 0.4, 0, 1 }, over={ 0.8, 0.8, 1, 1 } },
    strokeWidth = 4
}

-- Create the widget
local buttonDown = widget.newButton
{
    label = "buttonDown",
    onPress = handleButtonDownEvent,
    emboss = false,
    --properties for a rounded rectangle button...
    shape="circle",
	radius=buttonRadius,
    fillColor = { default={ 1, 0, 0, 1 }, over={ 1, 0.1, 0.7, 0.4 } },
    strokeColor = { default={ 1, 0.4, 0, 1 }, over={ 0.8, 0.8, 1, 1 } },
    strokeWidth = 4
}

-- Create the widget
local buttonUp = widget.newButton
{
    label = "buttonUp",
    onPress = handleButtonUpEvent,
    emboss = false,
    --properties for a rounded rectangle button...
    shape="circle",
	radius=buttonRadius,
    fillColor = { default={ 1, 0, 0, 1 }, over={ 1, 0.1, 0.7, 0.4 } },
    strokeColor = { default={ 1, 0.4, 0, 1 }, over={ 0.8, 0.8, 1, 1 } },
    strokeWidth = 4
}

local function setupButtons()  
	local centerButtonX = display.contentCenterX
	local centerButtonY = screenBottom - 10 - (buttonRadius*3)
	
	-- Center the button
	buttonDown.x = centerButtonX
	buttonDown.y = centerButtonY + (buttonRadius*2)

	-- Change the button's label text
	buttonDown:setLabel( "D" )
	
	-- Center the button
	buttonUp.x = centerButtonX
	buttonUp.y = centerButtonY - (buttonRadius*0.5)

	-- Change the button's label text
	buttonUp:setLabel( "U" )

	-- Center the button
	buttonRight.x = centerButtonX + (buttonRadius*2.5)
	buttonRight.y = centerButtonY + (buttonRadius*2)

	-- Change the button's label text
	buttonRight:setLabel( "R" )

	-- Center the button
	buttonLeft.x = centerButtonX - (buttonRadius*2.5)
	buttonLeft.y = centerButtonY + (buttonRadius*2)

	-- Change the button's label text
	buttonLeft:setLabel( "L" )
end

function startControllers(ch, pid, soc)
	chPlayer = ch
	playerId = pid
	serverSocket = soc
	setupButtons()
end