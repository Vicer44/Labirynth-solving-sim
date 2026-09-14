local CopyRight = {
  _VERSION     = 'O.1',
  _DESCRIPTION = 'Labirynth solving game',
  _URL         = 'https://github.com/Vicer44/Labirynth-solving-sim',
  _LICENSE     = [[
    MIT License

    Copyright (c) 2026 Vicer44

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
  ]]
}
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