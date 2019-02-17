require 'pp'
require 'set'

input = File.readlines("/Users/hsinghui/sandbox/advent_of_code/2018/inputs/day17.in").map { |x| x.strip }
input = File.readlines("/Users/hsinghui/sandbox/advent_of_code/2018/inputs/day17test.in").map { |x| x.strip }
# p input

grid = Hash.new { |h, k| h[k] = Hash.new }

max_col = 0
min_col = 10000000
input.each do |line|
  x, y = line.split(", ").sort
  _, xv = x.split("=")
  _, yv = y.split("=")
  if xv.include? ".."
    xa,xb = xv.split("..")
    (xa.to_i..xb.to_i).each do |col|
      grid[yv.to_i][col] = "#"
      if col < min_col
        min_col = col
      end
      if col > max_col
        max_col = col
      end
    end
  elsif yv.include? ".."
    xv = xv.to_i
    ya,yb = yv.split("..")
    (ya.to_i..yb.to_i).each do |row|
      grid[row.to_i][xv] = "#"
      if xv < min_col
        min_col = xv
      end
      if xv > max_col
        max_col = xv
      end
    end
  else
    # don't think this ever happens
    grid[yv.to_i][xv.to_i] = "#"
  end
end

min_row, max_row = grid.keys.minmax
p [min_row, max_row]
p [min_col, max_col]

def print_grid min_row, max_row, min_col, max_col, grid
  (min_row..max_row).each do |y|
    row = ""
    (min_col..max_col).each do |x|
      if !grid[y][x]
        row += "."
      else
        row += grid[y][x]
      end
    end
    puts row
  end
end
header = ""
(min_col..max_col).each do |x|
  if x == 500
  header += "+"
  else
    header += "."
  end
end

print header
puts
print_grid min_row, max_row, min_col, max_col, grid

# spring = [0, 500]

count = 0
static = []
flowing = []

start = [0, 500]
# y = 1
# x = 500

# Use BFS
queue = []
current = start
queue << current
y, x = current
# while y <= max_row
while !queue.empty?
  current = queue.shift
  y, x = current
  # check if it hits bottom of bucket. If so, do BFS until reach height of
  # bucket

  if grid[y][x] == "."
    grid[y][x] == "|"
    queue << [y+1, x]
  end
  if grid[y][x] == "#"
    grid[y][x] == "|"
    wet << [y, x]
    # p [y, x], queue
    neighbors = [
      [y, x-1],
      [y, x+1],
    ]

    neighbors.each do |j, i|
      p [j, i]
      if grid[j][i] != "#" && y > min_row
        p "bar"
        queue << [j, i]
        p [j, i]
      end
    end
  end
end

# def valid coord, grid
#   y, x = coord
#   return false if grid[y][x] != "#"
#   return false if y < 1
# end
p "COUNT: #{count}"
p wet
