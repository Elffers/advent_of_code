input = File.read("../day11.in").chomp
dirs = input.split(",")

def distance x, y
  if x.positive? == y.positive?
    [x.abs, y.abs].max
  else
    x.abs + y.abs
  end
end

x = 0
y = 0
max_distance = 0

dirs.each do |dir|
  case dir
  when "ne"
    y += 1
  when "sw"
    y -= 1
  when "nw"
    x += 1
  when "se"
    x -= 1
  when "n"
    y +=1
    x += 1
  when "s"
    y -=1
    x -= 1
  end
  max_distance = [distance(x,y), max_distance].max
end

p [x, y]
p part1: distance(x, y)
p part2: max_distance
