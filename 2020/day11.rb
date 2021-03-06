input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day11.in").map { |x| x.strip }

def populate(input)
  state = Array.new(input.size) { Array.new(input.first.size) }

  input.each_with_index do |row, i|
    row.chars.each_with_index do |s, j|

      adjacent = [
        [i-1, j-1], [i, j-1], [i+1, j-1],
        [i-1, j],             [i+1, j],
        [i-1, j+1], [i, j+1], [i+1, j+1],
      ]
      neighbors = adjacent.map do |n|
        x, y = n
        if x < state.size && x >= 0 && y < row.length && y >= 0
          input[x][y]
        end
      end.compact

      neighbors.delete(".")

      val = s
      case s
      when "L"
        if neighbors.all? { |n| n == "L" }
          val = "#"
        end

      when "#"
        if neighbors.count("#") >=4
          val = "L"
        end
      end

      state[i][j] = val
    end
  end
  state.map { |x| x.join }
end

def find_visible_neighbors(input, i, j)
  neighbors = []
  y_max = input.length
  x_max = input.first.length

  # search row i
  x0, xn = j-1, j+1
  while x0 >=0
    if input[i][x0] != "."
      neighbors << input[i][x0]
      break
    end
    x0 -= 1
  end

  while xn < x_max
    if input[i][xn] != "."
      neighbors << input[i][xn]
      break
    end
    xn += 1
  end

  # search y axis j
  y0, yn = i-1, i+1
  while y0 >=0
    if input[y0][j] != "."
      neighbors << input[y0][j]
      break
    end
    y0 -= 1
  end

  while yn < y_max
    if input[yn][j] != "."
      neighbors << input[yn][j]
      break
    end
    yn += 1
  end

  # search diagonals
  # NW
  x0 = j-1
  y0 = i-1

  while y0 >=0 && x0 >= 0
    if input[y0][x0] != "."
      neighbors << input[y0][x0]
      break
    end
    x0 -= 1
    y0 -= 1
  end

  # NE
  xn = j+1
  y0 = i-1
  while y0 >=0 && xn < x_max
    if input[y0][xn] != "."
      neighbors << input[y0][xn]
      break
    end
    xn += 1
    y0 -= 1
  end

  # SE
  xn = j+1
  yn = i+1
  while yn < y_max && xn < x_max
    if input[yn][xn] != "."
      neighbors << input[yn][xn]
      break
    end
    xn += 1
    yn += 1
  end

  # SW
  x0 = j-1
  yn = i+1
  while yn < y_max && x0 >= 0
    if input[yn][x0] != "."
      neighbors << input[yn][x0]
      break
    end
    x0 -= 1
    yn += 1
  end
  neighbors
end

def populate2(input)
  state = Array.new(input.size) { Array.new(input.first.size) }

  input.each_with_index do |row, i|
    row.chars.each_with_index do |s, j|

      neighbors = find_visible_neighbors(input, i, j)

      val = s
      case s
      when "L"
        if neighbors.all? { |n| n == "L" }
          val = "#"
        end

      when "#"
        if neighbors.count("#") >= 5
          val = "L"
        end
      end

      state[i][j] = val
    end
  end
  state.map { |x| x.join }
end

loop do
  state = populate2(input)
  count = input.join.count("#")
  input = state
  new_count =  state.join.count("#")

  if new_count == count
    p "part 2: #{new_count}"
    break
  end
  count = new_count
end
