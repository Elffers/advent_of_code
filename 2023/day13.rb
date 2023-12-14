grids = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day13.in").split("\n\n").map { |x| x.split("\n") }
# grids = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day13_test.in").split("\n\n").map { |x| x.split("\n") }


def reflections grid
  i = 0
  while i < grid.size
    # find shortest distance to top or bottom
    d1 = i+1
    d2 = grid.size-d1
    number_of_rows = [d1, d2].min
    # p "index: #{i}"

    n = 1
    x = i
    y = x + 1
    is_axis = false
    # p "num of rows: #{number_of_rows}"
    while n <= number_of_rows
      if grid[x]  == grid[y]
        p "got here: #{[x, y]}, i: #{i}, n: #{number_of_rows}"
        is_axis = true
        x -= 1
        y += 1
        n += 1
      else
        is_axis = false
        break
      end
    end

    if is_axis
      p "reflection at: #{d1}"
      return d1
    end

    i += 1
  end
end

def flip grid
  out = []
  i = 0
  while i < grid.first.size
    col = grid.map { |row| row[i] }.join
    out << col
    i += 1
  end
  out
end
flipped = flip grids.first

# p reflections flipped
# p reflections  grids.first
# p reflections grids.last

h = 0
v = 0

grids.each do |grid|
  res = reflections grid
  if res
    p "h: #{res }"
    h += res
  else
    res = reflections(flip grid)
    p "v: #{res }"
    v += res
  end
end
p [h, v]

p "Part 1: #{100*h + v}"

