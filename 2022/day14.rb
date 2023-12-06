input = File.read("/Users/hhhsu/sandbox/aoc/2022/inputs/day14.in").split "\n"
input = File.read("/Users/hhhsu/sandbox/aoc/2022/inputs/day14test.in").split "\n"

map = Hash.new { |h, k| h[k] = {} }
min_width = Float::INFINITY
max_width = 0

input.each do |path|
  nodes = path.split(" -> ").map do |pt|
    pt.split(",").map { |n| n.to_i }
  end
  curr = nodes.shift
  while !nodes.empty?
    car = nodes.shift
    x1, y1 = curr
    x2, y2 = car
    x_min, x_max = [x1, x2].minmax
    y_min, y_max = [y1, y2].minmax

    if x_min < min_width
      min_width = x_min
    end
    if x_max > max_width
      max_width = x_max
    end

    if y1 == y2
      (x_min..x_max).each do |x|
        map[y1][x] = "#"
      end
    elsif x1 == x2
      (y_min..y_max).each do |y|
        map[y][x1] = "#"
      end
    end
    curr = car
  end
end

pp map
p map.keys.max
p map[map.keys.max]
p min_width, max_width
width = max_width-min_width + 1
height = map.keys.max + 1
p [height, width]

def display map, width, height, min_width
  cols = Array.new height
  map.each_pair do |y, vals|
    row = Array.new(width, ".")
    vals.each_pair do |x, val|
      row[x-min_width] = val
    end
    cols[y] = row.join
  end
  cols.each do |row|
    puts row
  end
end

display map, width, height, min_width

src = [0, 500]

def fall src, map
  y, x = src
  pos = map[y][x]
  while pos.nil?
    pos = map[y][x]
    y+=1
  end
end
