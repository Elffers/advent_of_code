input = File.readlines("/Users/hsinghui/sandbox/advent_of_code/2018/inputs/day18.in").map { |x| x.strip }
# input = File.readlines("/Users/hsinghui/sandbox/advent_of_code/2018/inputs/day18test.in").map { |x| x.strip }

grid = Hash.new { |h, k| h[k] = Hash.new }

input.each_with_index do |line, j|
  line.chars.each_with_index do |c, i|
    grid[j][i] = c
  end
end

def print_grid grid
  grid.each do |k,row|
    p row.values.join
  end
end

def change grid
  wooded = 0
  lumber = 0
  new_grid = Hash.new { |h, k| h[k] = Hash.new }
  adj = [
    [-1, -1], [0, -1], [1, -1],
    [-1, 0],           [1, 0],
    [-1, 1], [0, 1], [1, 1],
  ]
  row_count = grid.keys.size
  col_count = grid[0].keys.size
  grid.each do |j, row|
    row.each do |i, acre|
      neighbors = adj.map do |x, y|
        if y + j >= 0 && x + i >= 0 && y + j < row_count && x + i < col_count
          grid[y + j][x + i]
        end
      end
      case acre
      when "."
        if neighbors.count("|") >= 3
          new_grid[j][i] = "|"
          wooded += 1
        else
          new_grid[j][i] = "."
        end
      when "|"
        if neighbors.count("#") >= 3
          new_grid[j][i] = "#"
          lumber += 1
        else
          new_grid[j][i] = "|"
          wooded += 1
        end
      when "#"
        if neighbors.count("#") >= 1 && neighbors.count("|") >= 1
          new_grid[j][i] = "#"
          lumber += 1
        else
          new_grid[j][i] = "."
        end
      else
        new_grid[j][i] = acre
      end
    end
  end
  # p wooded * lumber
  [new_grid, wooded * lumber]
end

count = 0
# 10.times do |i|
# 1000000000.times do |i|
counts = Hash.new 0
1000.times do |i|
  grid, count = change grid
  counts[count] += 1
  if counts[count] > 1
    p i
    break
  end

  p counts if i % 100 == 0
end
p "Part 1: #{count}"
