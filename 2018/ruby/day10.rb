require 'scanf'
require 'pp'

input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day10.in")

pos = []
vels = []
input.each do |line|
  # position=< 9,  1> velocity=< 0,  2>
  px, py, vx, vy = line.scanf("position=<%d,  %d> velocity=< %d,  %d>")
  pos <<  [px, py]
  vels << [vx, vy]
end

def print_message pos
  min_x, max_x = pos.map { |x| x.first}.minmax
  min_y, max_y = pos.map { |y| y.last}.minmax

  width = max_x - min_x + 1
  height = max_y - min_y + 1

  grid = []
  height.times do
    grid << " " * width
  end

  pos.each do |x, y|
    i = x - min_x
    j = y - min_y
    grid[j][i] = "#"
  end

  puts grid
end

def find_bounds pos
  min_x, max_x = pos.map { |x| x.first}.minmax
  min_y, max_y = pos.map { |y| y.last}.minmax
  width = max_x - min_x + 1
  height = max_y - min_y + 1
  [width, height]
end

def tick pos, vels
  new_pos = []
  pos.each_with_index do |pt, i|
    px, py = pt
    vx, vy = vels[i]
    new_pos << [px + vx, py + vy]
  end
  new_pos
end

old_pos = pos
min_w, min_h = find_bounds pos

t = 0
loop do
  t += 1

  old_pos = pos
  pos = tick(pos, vels)
  w, h = find_bounds pos

  if w < min_w || h < min_h
    min_w, min_h = w, h
  end

  if w > min_w || h > min_h
    break
  end
end

print_message old_pos
p "Part 2: #{t-1}"
