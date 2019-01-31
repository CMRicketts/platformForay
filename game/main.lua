function love.load()

  WINDOW_HEIGHT = love.graphics.getHeight()
  WINDOW_WIDTH = love.graphics.getWidth()
  GRAVITY = 100

  love.graphics.setNewFont(12)
  love.graphics.setColor(0,0,0)
  love.graphics.setBackgroundColor(255,255,255)

  love.graphics.setColor(45, 45, 45)
  floor = {color = "", x1 = WINDOW_HEIGHT-50, y1 = 0, x2 = 0, y2 = WINDOW_WIDTH-50}
  character = {outline = "line", x = 0, y = WINDOW_HEIGHT-10, width = 5, height = 10, speed = 200}

  love.graphics.line(floor.x1, floor.y1, floor.x2, floor.y2)
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

  direction = {"", ""}
  if love.keyboard.isDown("right") then
    direction[1] = "right"
  elseif love.keyboard.isDown("left") then
    direction[1] = "left"
  else
    direction[1] = nil
  end

  if love.keyboard.isDown("up") then
    direction[2] = "up"
  elseif love.keyboard.isDown("down") then
    direction[2] = "down"
  else
    direction[2] = nil
  end
  moveCharacter(direction, dt)
end


function moveCharacter(direction, dt)
  first = direction[1]
  sec = direction[2]
  dx = 0
  dy = 0
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
  if sec == "down" then
    if ((character.y + character.speed * dt) + character.height) >= WINDOW_HEIGHT then
      character.y = WINDOW_HEIGHT - character.height
    else 
      dy = character.speed * dt
    end
  elseif sec == "up" then
    --[[
    if (character.y - character.speed * dt) <= 0 then
      character.y = 0
    else 
      dy = 0 - character.speed * dt
    end]]
    creatureJump(character, dt)
  end
  character.x = character.x + dx
  character.y = character.y + dy
end

function love.quit()
  print("Thanks for playing! Come back soon!")
end

function creatureJump(creature, dt) 
  ground = WINDOW_HEIGHT - character.height
  vel = 0
  jumpHeight = 400
  if vel == 0 then
    vel = jumpHeight
  end
  if vel ~= 0 then 
    creature.y = creature.y + vel * dt
    vel = vel - GRAVITY * dt
  end
  if creature.y > WINDOW_HEIGHT - creature.height then
    vel = 0
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
end


-- "C:\Program Files\LOVE\lovec.exe" "C:\Users\ricke\Desktop\code\lua\game"