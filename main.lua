require "SnakeBody"
require "Walls"


local timer = 0.0
local last_moved_direction = "R"
local direction = "R"
local MOVE_TIMELIMIT = 0.3
local is_game_over = false

function love.load()
    love.graphics.setBackgroundColor(0,0,0)
    world = love.physics.newWorld(0, 0, true)
    world:setCallbacks(beginContact, nil, nil, nil)

    wall = Walls.new(world)

    -- X, Y coordinates were chosen as custom choice for snake setup
    local START_X = 3
    local START_Y = 3
    snake_body = SnakeBody.init(START_X, START_Y, world)

    text = ""
end


function beginContact(a, b, coll)
    is_game_over = true
    x, y = coll:getNormal()
    text = text.."\n".. a:getUserData().." colliding with "..b:getUserData().." with a vector normal of: "..x..", "..y
end

function love.draw()
    Walls.draw(wall)
    SnakeBody.draw(snake_body)
    love.graphics.print(text, 10, 80)
end


function love.update(dt)
    if is_game_over then
        return
    end

    world:update(dt)

    timer = timer + dt
    if isTimeToMove(timer) then
        timer = 0.0
        SnakeBody.move(snake_body, direction)
        -- we need to save the last moved direction, because otherwise it is possible to change
        -- direction from U -> R -> D (in the interval of MOVE_TIMELIMIT) which means that the snake 
        -- will change directions U -> D and this change of directions should not be allowed
        last_moved_direction = direction
    end
end


function isTimeToMove(timer)
    return timer > MOVE_TIMELIMIT
end


function love.keypressed(key, scancode, isrepeat)
    new_direction = getNewDirection(key)
    if (isVerticalDirection(last_moved_direction) and isHorizontalDirection(new_direction)) or
            isHorizontalDirection(last_moved_direction) and isVerticalDirection(new_direction) then
        direction = new_direction
    end
end


function getNewDirection(key)
    new_direction = nil
    if(key == "up") then
        new_direction = "U"
    elseif(key == "down") then
        new_direction = "D"
    elseif(key == "right") then
        new_direction = "R"
    elseif(key == "left") then
        new_direction = "L"
    end

    return new_direction
end


function isVerticalDirection(direction)
    return direction == "U" or direction == "D"
end


function isHorizontalDirection(direction)
    return direction == "L" or direction == "R"
end


function love.conf(t)
    -- enable printing messages to console
    t.console = true
end