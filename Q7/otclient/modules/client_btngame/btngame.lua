mainWindow = nil
btn = nil

local speed = 0.3
local lastTime = g_clock:millis()
local isActive = false

--Initial code to setup a module, requires the init and terminate functions
function init()
    --Subscribe to onGameStart and onGameEnd
    connect(g_game, { onGameStart = update,
                      onGameEnd = stop })
    
    --Display the window and and get the button by Id
    mainWindow = g_ui.displayUI('btngame', modules.game_interface.getRightPanel())
    btn = mainWindow:getChildById('movingButton')
end

function terminate()
    disconnect(g_game, { onGameStart = update,
                         onGameEnd = stop })
end

--Show the window and start the button movement when the game starts
function update()
    mainWindow:show()
    startMoving()
end

--Stop the button movement and close the window when game stops
function stop()
    isActive = false
    mainWindow:hide()
end

--Set active to true so that moveBtn keeps triggering
function startMoving()
    isActive = true
    moveBtn()
end

--Resets the x position of the button to 0 and gets a random offset inside the window 
--Removing double the height of the button because the pivot is not in the center, and it also accomodates for the top title bar of the window
--This function is also called whent he button is pressed, it is linked in the btngame.otui @onClick: resetBtnPosition()
function resetBtnPosition()
    btn:setMarginRight(0)
    --Add button full height amd the window border height to the offset
    local maxY = mainWindow:getHeight() - (btn:getHeight() * 2) - 27;
    btn:setMarginBottom(math.random(0, maxY))
  end

--Move the button
function moveBtn()
    --Calculate a deltaTime to make movement smoother and be able to use speed as a variable
    local currentTime = g_clock:millis()
    local deltaTime = currentTime - lastTime
    lastTime = currentTime
    local distance = speed * deltaTime

    --Add offset based on the distance calculated from speed x time
    local delta = btn:getMarginRight() + distance
    btn:setMarginRight(delta)

    --When the button reaches the edge of the window we call the reset function
    local maxX = mainWindow:getWidth() - btn:getWidth() - 6 -- 6 is the border of the window
    if maxX <= btn:getMarginRight() then
        resetBtnPosition()
    end
    print(btn:getMarginRight())
    --If window is still active we schedule a call to the movement function 
    if isActive then
        scheduleEvent(moveBtn, 100)
    end
  end