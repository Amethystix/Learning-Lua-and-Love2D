
function love.load()
    timer = 30
    score = 0
    gameState = 0
    gameHasEnded = false
    love.window.setTitle('Boxy chase!')
    myPlayer = {
        x = love.graphics.getWidth() / 2 - 50,
        y = love.graphics.getHeight() / 2 - 50,
        image = love.graphics.newImage('assets/boxy.png')
    }

    myObjective = {
        x = math.random(0, love.graphics.getWidth() - 100),
        y = math.random(0, love.graphics.getHeight() + 100),
        image = love.graphics.newImage('assets/carrot.png')
    }
end

function love.update(dt)
    if (gameState == 1) then
        if (timer > 0) then
            timer = timer - dt
        else
            timer = 0
            gameState = 0
            gameHasEnded = true
        end

        checkForPlayerMovement()
        local hasCollisionHappened = checkForCollision(myPlayer, myObjective)
        if (hasCollisionHappened ~= nil) then
            myObjective.x = hasCollisionHappened.x
            myObjective.y = hasCollisionHappened.y
        end
    else
        if (love.keyboard.isDown('return')) then
            gameState = 1

            if (gameHasEnded) then
                score = 0
                timer = 30
                gameHasEnded = false
                myPlayer.x = 0
                myPlayer.y = 0
            end
        end
    end
end

function love.draw()
    love.graphics.setNewFont(50)
    love.graphics.print(math.ceil(timer), love.graphics.getWidth() - 100, 0)
    love.graphics.print(score, 10, 0)

    if (gameState == 1) then
        love.graphics.draw(myPlayer.image, myPlayer.x, myPlayer.y)
        love.graphics.draw(myObjective.image, myObjective.x, myObjective.y)
    else
        love.graphics.setNewFont(25)
        love.graphics.print('Press the enter key to begin', 200, 275)

        if (gameHasEnded) then
            love.graphics.print('GAME OVER!  Your score was ' .. score, 150, 200)
        end
    end
end

function distance (x1, y1, x2, y2)
    local dx = x1 - x2
    local dy = y1 - y2
    return math.sqrt ( dx * dx + dy * dy )
end

function checkForCollision(obj1, obj2)
    if (distance(obj1.x + 50, obj1.y + 50, obj2.x + 37, obj2.y + 37) < 50) then
        score = score + 1
        newPosition = {
            x = math.random(0, love.graphics.getWidth() - 100),
            y = math.random(0, love.graphics.getHeight() - 100)
        }
        return newPosition
    else
        return nil
    end
end
    

function checkForPlayerMovement()
    if (love.keyboard.isDown('d') and myPlayer.x < love.graphics.getWidth() - 100) then
        myPlayer.x = myPlayer.x + 1
    end

    if (love.keyboard.isDown('a') and myPlayer.x > 0) then
        myPlayer.x = myPlayer.x - 1
    end

    if (love.keyboard.isDown('w') and myPlayer.y > 0) then
        myPlayer.y = myPlayer.y - 1
    end

    if (love.keyboard.isDown('s') and myPlayer.y < love.graphics.getHeight() - 100) then
        myPlayer.y = myPlayer.y + 1
    end
end