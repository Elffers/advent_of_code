require 'pp'
serial = 3999
n = 300

def power_level(i, j, serial)
  rack_id = i + 10
  power_level = (rack_id * j) + serial
  power_level *= rack_id
  r = power_level % 100
  power_level = (power_level - r)
  power_level = power_level/ 100
  power_level= power_level % 10
  power_level -= 5
end

# grid = Hash.new { |h, k| h[k] = Hash.new }
max = 0
max_pts = nil
(1..n).each do |i|
  (1..n).each do |j|
    if i+2 > 300 || j+2 > 300
      # next
    end

    sum = power_level(i, j, serial) + power_level(i, j+1, serial) + power_level(i, j+2, serial) + power_level(i+1, j, serial) + power_level(i+1, j+1, serial) + power_level(i+1, j+2, serial) + power_level(i+2, j, serial) + power_level(i+2, j+1, serial) + power_level(i+2, j+2, serial)

    if sum > max
      max = sum
      max_pts = [i, j]
    end

    # grid[i][j] = sum
  end
end
p max, max_pts

# p grid[20][61]
# serial = 42
# i = 21
# j = 61
# p power_level(i, j, serial)
# p power_level(i, j+1, serial)
# p power_level(i, j+2, serial)
# puts
# p power_level(i+1, j, serial)
# p power_level(i+1, j+1, serial)
# p power_level(i+1, j+2, serial)

# p power_level(i+2, j, serial)
# p power_level(i+2, j+1, serial)
# p power_level(i+2, j+2, serial)

# puts grid[21][61]
# puts grid[20][61]
# puts grid[20][62]
# puts grid[21][60]
# puts grid[21][61]
# puts grid[21][62]
# puts grid[22][60]
# puts grid[22][61]
# puts grid[22][62]

# grid.each do |h, k|

# pp grid
# p power_level(3, 5, 8)
# p power_level(122, 79, 57)
# p power_level(217,196, 39)
# p power_level(101,153, 71)
