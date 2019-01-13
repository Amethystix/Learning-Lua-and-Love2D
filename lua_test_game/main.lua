

function makeTheBall(direction, xVal)
    theBall = {}
    if (direction > 0) then
        theBall = {
            x = xVal,
            y = 50,
            direction = 1
        }
    else
        theBall = {
            x = xVal,
            y = 550,
            direction = -1
        }
    end
    return theBall
end
    

arr = {}

for i = 1, 10, 1 do
    direction = 1
    if i % 2 == 0 then
        direction = -1
    end
    table.insert(arr, makeTheBall(direction, (i-1)*100 + 50))
end

function love.draw()
    love.graphics.setFont(love.graphics.newFont(50))
    love.graphics.setBackgroundColor(255, 0, 255)
    for i,s in ipairs(arr) do
        love.graphics.print(s.y, 300, i*75)
        moveTheBall(s)
        if (s.direction == 1) then
            s.y = s.y + 5
            love.graphics.ellipse('fill', s.x, s.y, 50, 50)
        else
            s.y = s.y - 5
            love.graphics.ellipse('fill', s.x, s.y, 50, 50)
        end
    end
end

function moveTheBall(ball)
    if (ball.y > love.graphics.getHeight()) then
        ball.direction = -1
    elseif (ball.y < 0) then
        ball.direction = 1
    end
end

