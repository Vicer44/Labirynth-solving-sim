function love.load()
    anim8 = require 'liblaries/anim8'
    love.graphics.setDefaultFilter("nearest","nearest")

    player = {}
    player.x = 400
    player.y = 200
    player.speed = 3
    player.sprite = love.graphics.newImage('sprites/parrot.png')
    player.spriteSheet = love.graphics.newImage('sprites/playersheet.png')
    player.grid = anim8.newGrid( 12, 18, player.spriteSheet:getWidth(), player.spriteSheet:getHeight() )

    player.animation ={}
    player.animation.down = anim8.newAnimation( player.grid('1-4', 1), 0.2 )
    player.animation.left = anim8.newAnimation( player.grid('1-4', 2), 0.2 )
    player.animation.rigth = anim8.newAnimation( player.grid('1-4', 3), 0.2 )
    player.animation.up = anim8.newAnimation( player.grid('1-4', 4), 0.2 )

    player.anim = player.animation.left

    background = love.graphics.newImage('sprites/background.png')
end

function love.update(dt)
    local isMoving = false

    if love.keyboard.isDown('d') or love.keyboard.isDown('right') then
        player.x = player.x + player.speed
        player.anim = player.animation.rigth
        isMoving = true
    end
    if love.keyboard.isDown('a') or love.keyboard.isDown('left') then
        player.x = player.x - player.speed
        player.anim = player.animation.left
        isMoving = true
    end
    if love.keyboard.isDown('w') or love.keyboard.isDown('up') then
        player.y = player.y - player.speed
        player.anim = player.animation.up
        isMoving = true
    end
    if love.keyboard.isDown('s') or love.keyboard.isDown('down') then
        player.y = player.y + player.speed
        player.anim = player.animation.down
        isMoving = true
    end

    if isMoving == false then 
        player.anim:gotoFrame(2)
    end
    player.anim:update(dt)
end

function love.draw()
    love.graphics.draw(background, 0,0)
    player.anim:draw(player.spriteSheet, player.x, player.y, nil, 10  )
end