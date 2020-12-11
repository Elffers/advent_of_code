input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day11.in").map { |x| x.strip }

# input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day11test.in").map { |x| x.strip }

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

loop do
  state = populate(input)
  count = input.join.count("#")
  input = state
  new_count =  state.join.count("#")

  if new_count == count
    p "part 1: #{new_count}"
    break
  end
  count = new_count
end
