require "Queue"
require "SnakeCell"

local BORDER = 1
local TILE_SIZE = 16

SnakeBody = {}
function SnakeBody.init(start_xtile, start_ytile, world)
    snake_body = Queue.new()
    SnakeBody._appendAsNewHead(snake_body, SnakeCell.new(start_xtile, start_ytile, world))
    SnakeBody._appendAsNewHead(snake_body, SnakeCell.new(start_xtile+1, start_ytile, world))
    SnakeBody._appendAsNewHead(snake_body, SnakeCell.new(start_xtile+2, start_ytile, world))
    return snake_body
end


function SnakeBody._appendAsNewHead(snake_body, new_head)
    return Queue.pushright(snake_body, new_head)
end


function SnakeBody.move(snake_body, direction)
    -- we remove the tail from the snake and append it to the
    -- head with new coordinates
    head = SnakeBody._getHead(snake_body)
    cell = SnakeBody._removeTail(snake_body)
    if direction == "U" then
        cell.x = head.x
        cell.y = head.y - 1
    elseif direction == "D" then
        cell.x = head.x
        cell.y = head.y + 1
    elseif direction == "L" then
        cell.x = head.x - 1
        cell.y = head.y
    elseif direction == "R" then
        cell.x = head.x + 1
        cell.y = head.y
    end
    cell.b:setX(cell.x*16+8)
    cell.b:setY(cell.y*16+8)
    SnakeBody._appendAsNewHead(snake_body, cell)
end


function SnakeBody._getHead(snake_body)
    return snake_body[snake_body.last]
end


function SnakeBody._removeTail(snake_body)
    return Queue.popleft(snake_body)
end


function SnakeBody.draw(snake_body)
    for i = snake_body.first, snake_body.last do
        local snake_cell = snake_body[i]
        --love.graphics.rectangle("fill", snake_cell.x*TILE_SIZE, 
        --                        snake_cell.y*TILE_SIZE, TILE_SIZE-BORDER, TILE_SIZE-BORDER)
        love.graphics.polygon("fill", snake_cell.b:getWorldPoints(snake_cell.s:getPoints()))
    end
end