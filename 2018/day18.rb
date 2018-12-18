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

def count grid
  wooded = 0
  lumber = 0
  grid.each do |k,row|
    row.each do |i, acre|
      wooded += 1 if acre == "|"
      lumber += 1 if acre == "#"
    end
  end
  wooded * lumber
end

# print_grid grid
#
def change grid
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
      # p "neighbors for #{[j, i]}: #{neighbors.compact.join}"
      case acre
      when "."
        if neighbors.count("|") >= 3
          new_grid[j][i] = "|"
        else
          new_grid[j][i] = "."
        end
      when "|"
        if neighbors.count("#") >= 3
          new_grid[j][i] = "#"
        else
          new_grid[j][i] = "|"
        end
      when "#"
        if neighbors.count("#") >= 1 && neighbors.count("|") >= 1
          new_grid[j][i] = "#"
        else
          new_grid[j][i] = "."
        end
      else
        new_grid[j][i] = acre
      end
    end
  end
  new_grid
end

# 1000000000.times do |i|
10.times do
  grid = change grid
end
p "Part 1: #{count grid}"
