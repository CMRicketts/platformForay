function love.load()

  WINDOW_HEIGHT = love.graphics.getHeight()
  WINDOW_WIDTH = love.graphics.getWidth()
  GRAVITY = 250

  love.graphics.setNewFont(12)
  love.graphics.setColor(0,0,0)
  love.graphics.setBackgroundColor(255,255,255)

  love.graphics.setColor(45, 45, 45)
  character = {outline = "fill", x = 0, y = WINDOW_HEIGHT-10, width = 5, height = 10, speed = 200, yVel = 0, jumpHeight = 150}

end

function love.draw()
  love.graphics.setColor(0,0,0)
  love.graphics.rectangle(character.outline, character.x, character.y, character.width, character.height)
end

function love.focus(f)
  if not f then
    print("LOST FOCUS")
  else
    print("GAINED FOCUS")
  end
end

function love.update(dt)
  if love.keyboard.isDown("escape") then
    love.event.quit()
  end

  if love.keyboard.isDown("r") then
    love.event.quit("restart")
  end

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
    print("going up by ", GRAVITY * dt)
    print("going down by ", character.yVel * dt)
    character.yVel = character.yVel - GRAVITY * dt
    character.y = character.y - character.yVel * dt
  end
  if character.y >= WINDOW_HEIGHT - character.height then
    character.yVel = 0
    character.y = WINDOW_HEIGHT - character.height
  end
  if character.y <= 0 then
    character.y = 0
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

--[[function creatureJump(creature, dt) 
  ground = WINDOW_HEIGHT - character.height
  print(ground, creature.y)
  jumpHeight = 150
  if creature.yVel == 0 then
    print("vel = 0")
    creature.yVel = jumpHeight
  end
  if creature.yVel ~= 0 then 
    print("should be going up?")
    creature.y = creature.y - creature.yVel * dt
    creature.yVel = creature.yVel + GRAVITY * dt
  end
  if creature.y > WINDOW_HEIGHT - creature.height then
    creature.yVel = 0
    creature.y = WINDOW_HEIGHT - creature.height
  end
end


function checkCollision(x, y) 
  if x > WINDOW_WIDTH then
    x = WINDOW_WIDTH
  elseif x < 0 then
    x = 0
  elseif y > WINDOW_HEIGHT then
    y = WINDOW_HEIGHT 
  elseif y < 0 then
    y = 0
  end
end]]


-- "C:\Program Files\LOVE\lovec.exe" "C:\Users\ricke\Desktop\code\lua\platformForay\game"
-- "C:\Program Files\LOVE\lovec.exe" "C:\Users\Name\Desktop\code\lua\platformForay\game"