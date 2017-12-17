steps = 349

# Part 1
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

# Part 2
res = nil
(1..50_000_000).each do |size|
  current = (current + steps) % size
  if current == 0
    res = size
  end
  current += 1
end
p res
