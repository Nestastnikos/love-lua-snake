Walls = {}
function Walls.new(world)
    static = {}
    static.b = love.physics.newBody(world, 14*16,3*16, "static") -- "static" makes it not move
    static.s = love.physics.newRectangleShape(12*16,3*16)         -- set size to 200,50 (x,y)
    static.f = love.physics.newFixture(static.b, static.s)
    static.f:setUserData("Wall")
    return static
end

function Walls.draw(walls)
    love.graphics.polygon("fill", walls.b:getWorldPoints(walls.s:getPoints()))
end