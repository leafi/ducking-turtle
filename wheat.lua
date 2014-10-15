local Lefts = 33
local Forwards = 18

function find(iname, start)
  local dpre = turtle.getItemDetail()
  if dpre and dpre.name == iname then
    return true
  end
  if not start then start = 1 end
  for i = start,16 do
    local d = turtle.getItemDetail(i)
    if d and d.name == iname then
      turtle.select(i)
      return true
    end
  end
  return false
end

function dump(iname)
  turtle.turnRight()
  while find(iname) do
    turtle.drop()
  end
  turtle.turnLeft()
end

function checkFuel()
  local fueln = math.ceil(Lefts * Forwards * 2.1)
  while turtle.getFuelLevel() < fueln do
    find("minecraft:coal")
    if not turtle.refuel() then
      error("NEED MORE COAL")
    end
  end
end

function digLine()
  local f = 0
  for i = 1,Forwards do
    if turtle.forward() then f = f + 1 end
    turtle.digDown()
    if find("minecraft:wheat_seeds") then turtle.placeDown() end
  end
  for i = 1,f do
    while not turtle.back() do end
  end
end

while true do
  local l = 0
  checkFuel()
  for i = 1,Lefts do
    digLine()
    while not turtle.turnLeft() do end
    if turtle.forward() then l = l + 1 end
    while not turtle.turnRight() do end
  end
  while not turtle.turnRight() do end
  for i = 1,l do
    while not turtle.forward() do end
  end
  while not turtle.turnLeft() do end

  dump("minecraft:wheat")
  dump("minecraft:wheat_seeds")

  os.sleep(300)
end

