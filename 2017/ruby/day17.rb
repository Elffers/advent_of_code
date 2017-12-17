steps = 349

buffer = [0]
current = 0
val = 1
while val < 2018
  current = (current + steps) % buffer.size
  current += 1
  buffer.insert(current, val)
  val += 1
end
p buffer[current + 1]
