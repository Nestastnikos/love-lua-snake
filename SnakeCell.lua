SnakeCell = {}
function SnakeCell.new(x_cell, y_cell, world)
    o = {}
    o = {}
    o.b = love.physics.newBody(world, x_cell*16+8,y_cell*16+8, "dynamic") -- "static" makes it not move
    o.s = love.physics.newRectangleShape(15,15)         -- set size to 200,50 (x,y)
    o.f = love.physics.newFixture(o.b, o.s)
    o.f:setUserData("Snake")
    o.x = x_cell
    o.y = y_cell
    return o
end