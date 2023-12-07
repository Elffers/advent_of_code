require 'strscan'

rows = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day03.in").split("\n")
# rows = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day03_test.in").split("\n")


# returns all adjacent values to a given position in a grid (horizontal,
# vertical, diagonal)
GEARS = Hash.new { |h, k| h[k] = [] }

def neighbors x, y, len, grid, num
  neighbors = []
  [-1, 0, 1].each do |i|
    (-1..len).each do |j|
      dx, dy = x+i, y+j
      # p [dx, dy]
      if dx >= 0 && dx < grid.size && dy >= 0 && dy < grid.first.size
        val = grid[dx][dy]
        if val && (val != ".") && (!val.match?(/\d/))
          neighbors << val
        end
        if val && (val == "*")
          GEARS[[dx, dy]] << num
        end
      end
    end
  end
  neighbors
end

sum = 0
rows.each.with_index do |row, x|
  s = StringScanner.new(row)
  while !s.eos?
    if s.match?(/\d+/)
      # p s.matched
      y = s.pos
      len = s.matched.size
      # for range of y values in each row, need to check rectangle
      ns = neighbors x, y, len, rows, s.matched
      if !ns.empty?
        sum += s.matched.to_i
        # p [ns, s.matched]
      end

      s.pos += len
    end
    s.getch
  end
end

p sum

ratios = 0
GEARS.values.each do |nums|
  if nums.length == 2
    ratios += nums.map{ |x| x.to_i }.reduce(:*)
  end
end
p ratios

