require 'pp'

input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day17.in").map { |x| x.strip }
# input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day17test.in").map { |x| x.strip }

grid = Hash.new { |h, k| h[k] = Hash.new "." }

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
# p [min_row, max_row]
# p [min_col, max_col]
def print_grid min_row, max_row, min_col, max_col, grid
  wet = 0
  static = 0
  (min_row..max_row).each do |y|
    row = ""
    (min_col..max_col).each do |x|
      row += grid[y][x]

      tile = grid[y][x]
      if tile == "|" || tile == "~"
        wet +=1
      end
      if tile == "~"
        static += 1
      end

    end
    puts row
  end
  puts
  p "WET: #{wet}"
  # p static: static
end

header = ""
(min_col..max_col).each do |c|
  if c == 500
    header += "+"
  else
    header += "."
  end
end

# puts
# print header
# puts
# print_grid min_row, max_row, min_col, max_col, grid

count = 0
flowing = []

current = [0, 500]
queue = []
queue << current

while !queue.empty?
  # break if count > 1000
  y, x = queue.shift
  down = grid[y+1][x]

  if down == "."
    grid[y][x] = "|"
    flowing << [y, x] if !flowing.include? [y, x] # Keep track of last flowing tile
    if y+1 <= max_row
      queue << [y+1, x] if !flowing.include? [y+1, x] # Enqueue next open tile
    end
  end

  # check if it hits bottom of bucket or top of block. If so, do BFS until reach height of bucket
  if down == "#" || down == "~"
    row = []
    row << [y, x]
    l = x - 1
    r = x + 1
    left_wall = false
    right_wall = false

    # Search left
    # store left side of row until hits a wall or drops off
    # if hits a wall, check if right side hits a wall
    # if right side hits wall, everything in row is static

    search_left = true
    while search_left
      left_n = grid[y][l]
      if left_n == "#"
        left_wall = true
        search_left = false
        break
      end

      if left_n == "."
        down_n = grid[y+1][l]
        if down_n == "."
          if y+1 <= max_row
            queue << [y+1, l]
          end
          search_left = false
        end
      end
      row << [y, l]
      l -= 1
    end

    search_right = true
    while search_right
      right_n = grid[y][r]
      if right_n == "#"
        right_wall = true
        search_right = false
        break
      end

      if right_n == "."
        down_n = grid[y+1][r]
        if down_n == "."
          if y+1 <= max_row
            queue << [y+1, r]
          end
          search_right = false
        end
      end
      row << [y, r]
      r += 1
    end

    if right_wall && left_wall
      row.each do |j, i|
        grid[j][i] = "~"
      end
    else
      row.each do |j, i|
        grid[j][i] = "|"
        flowing << [j, i] if !flowing.include? [j, i]
      end
    end

    # Go back to last known flowing tile FIXME
    if queue.empty?
      fy, fx = flowing.pop
      until grid[fy][fx] == "|"
        fy, fx = flowing.pop
        p flowing.count
      end
      p last_flowing: [fy, fx]
      queue << [fy, fx]
    end
  end

  # print_grid min_row, max_row, min_col, max_col, grid
  # p queue: queue
  count += 1
end

puts
print header
puts
print_grid min_row, max_row, min_col, max_col, grid

p flowing: flowing
p queue: queue

p "COUNT: #{count}"
