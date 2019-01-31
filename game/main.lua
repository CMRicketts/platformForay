function love.load()
  fizz = require("fizzx.fizz")

  WINDOW_HEIGHT = love.graphics.getHeight()
  WINDOW_WIDTH = love.graphics.getWidth()
  YGRAVITY = 250

  IS_PAUSED = false

  fizz.setGravity(0, YGRAVITY)

  love.graphics.setNewFont(12)
  love.graphics.setColor(0,0,0)
  love.graphics.setBackgroundColor(255,255,255)

  love.graphics.setColor(45, 45, 45)
  character = {outline = "fill", x = 0, y = WINDOW_HEIGHT - 10, width = 5, height = 10, speed = 200, yVel = 0, jumpHeight = 150}

  platform = {outline = "fill", x = 0, y = 0, height = 5, width = 30}
end

function love.draw()
  love.graphics.setColor(0,0,0)
  love.graphics.rectangle(character.outline, character.x, character.y, character.width, character.height)
end

function love.focus(f)
  if not f then
    IS_PAUSED = true
  else
    IS_PAUSED = false
  end
end

function love.update(dt)
  if love.keyboard.isDown("escape") then
    love.event.quit()
  end

  if love.keyboard.isDown("r") then
    love.event.quit("restart")
  end

  if not IS_PAUSED then
    direction = {"", ""}
    if love.keyboard.isDown("right") then
      direction[1] = "right"
    elseif love.keyboard.isDown("left") then
      direction[1] = "left"
    else
      direction[1] = nil
    end
    moveCharacter(direction, dt)
    if love.keyboard.isDown("up") then
      if character.yVel == 0 then
        character.yVel = character.jumpHeight
      end
    end
    if character.yVel ~= 0 then
      character.yVel = character.yVel - YGRAVITY * dt
      character.y = character.y - character.yVel * dt
    end
    if character.y >= WINDOW_HEIGHT - character.height then
      character.yVel = 0
      character.y = WINDOW_HEIGHT - character.height
    end
    if character.y <= 0 then
      character.y = 0
    end
    if love.keyboard.isDown("down") then
      character.yVel = character.yVel - YGRAVITY * dt * 2
      character.y = character.y - character.yVel * dt * 2
    end
  end
end

function moveCharacter(direction, dt)
  first = direction[1]
  dx = 0
  if first == "right" then
    if ((character.x + character.speed * dt) + character.width) >= WINDOW_WIDTH then
      character.x = WINDOW_WIDTH - character.width
    else 
      dx = character.speed * dt
    end
  elseif first == "left" then
    if (character.x - character.speed * dt) <= 0 then
      character.x = 0
    else 
      dx = 0 - character.speed * dt
    end
  end
  character.x = character.x + dx
end

function love.quit()
  print("Thanks for playing! Come back soon!")
end


-- "C:\Program Files\LOVE\lovec.exe" "C:\Users\ricke\Desktop\code\lua\platformForay\game"
-- "C:\Program Files\LOVE\lovec.exe" "C:\Users\Name\Desktop\code\lua\platformForay\game"