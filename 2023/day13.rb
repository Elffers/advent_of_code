require 'pp'
grids = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day13.in").split("\n\n").map { |x| x.split("\n") }
grids = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day13_test.in").split("\n\n").map { |x| x.split("\n") }

def reflections grid
  # print grid
  i = 0
  while i < grid.size
    # find shortest distance to top or bottom
    d1 = i+1
    d2 = grid.size-d1
    number_of_rows = [d1, d2].min

    n = 1
    x = i
    y = x + 1
    is_axis = false
    while n <= number_of_rows
      if grid[x]  == grid[y]
        # p "got here: #{[x, y]}, i: #{i}, n: #{number_of_rows}"
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
      # p "reflection at: #{d1}"
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

def old_reflection grid
  vert = false
  res = reflections grid
  if res
    return [res, vert]
  else
    res = reflections(flip grid)
    vert = true if res
    # puts "VERT: #{[i, j]}"
    return [res, vert]
  end
end

# flipped = flip grids.first
# p reflections flipped
# p reflections grids.first
# p reflections grids.last

def run grids, cache
  h = 0
  v = 0

  grids.each.with_index do |grid, i|
    res = reflections grid
    if res
      # p "h: #{res }"
      h += res
      cache[i] = [res, false]
    else
      res = reflections(flip grid)
      # p "v: #{res }"
      v += res
      cache[i] = [res, true]
    end
  end
  out = 100*h + v
  [out, cache]
end

cache = {}
out, cache = run grids, cache
p "Part 1: #{out}"
# p cache
puts

def print grid
  grid.each do |x|
    puts x
  end
  puts
end

def new_axis grid, old_axis
  # print grid
  i = 0
  while i < grid.size
    # find shortest distance to top or bottom
    d1 = i+1
    d2 = grid.size-d1
    number_of_rows = [d1, d2].min

    n = 1
    x = i
    y = x + 1
    is_axis = false
    while n <= number_of_rows
      if grid[x]  == grid[y]
        # p "got here: #{[x, y]}, i: #{i}, n: #{number_of_rows}"
        is_axis = true
        x -= 1
        y += 1
        n += 1
      else
        is_axis = false
        break
      end
    end

    if is_axis && d1 != old_axis
      # p "reflection at: #{d1}"
      return d1
    end

    i += 1
  end
end

def new_reflection grid, old_axis, was_vert
  i = 0
  while i < grid.size
    new_grid = grid.dup
    j = 0
    while j < grid.first.size
      vert = false
      # p [i, j]
      char = grid[i][j]
      new_grid[i][j] = char == "#" ? "." : "#"

      res = new_axis new_grid, old_axis
      if res # && !was_vert
        return [res, vert]
      else
        res = new_axis(flip(new_grid), old_axis)
        vert = true if res
        if res #&& was_vert
          return [res, vert]
        end
      end
      new_grid[i][j] = char
      j += 1
    end
    i += 1
  end
end

h = 0
v = 0
grids.each.with_index do |grid, i|
  old_axis, was_vert = cache[i]
  res, vert = new_reflection grid, old_axis, was_vert
  if res.nil?
    p "indx: #{i}"
    print grid
    p "cache: #{cache[i]}"
  end
  if vert
    v += res
  else
    h += res
  end
end

p 100*h + v
