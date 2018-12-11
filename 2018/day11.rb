require 'pp'

def power_level(i, j, serial)
  rack_id = i + 10
  pwr = (rack_id * j) + serial
  pwr *= rack_id
  pwr = (pwr/ 100) % 10 - 5
end

def grid(serial)
  (1..300).map do |x|
    (1..300).map do |y|
      power_level(x, y, serial)
    end
  end
end

def max_square_sum(i, j, dim, grid)
  pts = nil
  max = 0

  # find which dimension has greatest square sum at a given point
  (3..dim).each do |n|
    sum = square_sum(i, j, n, grid)
    if sum > max
      max = sum
      pts = [i, j, n]
    end
  end

  [pts, max]
end

def square_sum(i, j, dim, grid)
  sum = 0
  (i...i+dim).each do |x|
    (j...j+dim).each do |y|

      if x > 300-dim || y > 300-dim
        next
      end

      sum += grid[x-1][y-1]
    end
  end
  sum
end

serial = 3999
grid = grid(serial)

max = 0
max_pts = nil
max_square = nil
max_square_sum = 10

n = 300
(1..n).each do |i|
  (1..n).each do |j|

    sum = square_sum(i, j, 3, grid)
    # ms, mss = max_square_sum(i, j, 70, grid)

    # if mss > max_square_sum
    #   max_square_sum = mss
    #   max_square = ms
    #   p [ms, mss]
    # end

    if sum > max
      max = sum
      max_pts = [i, j]
    end
  end
end

p "Part 1: #{max}, #{max_pts}"
p "Part 2: #{max_square_sum}, #{max_square}"
