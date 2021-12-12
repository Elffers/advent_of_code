require 'set'
input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day11test.in").split("\n")
input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day11.in").split("\n")

@h = input.size
@w = input.first.size

def neighbors x, y
  dirs = [
    [-1, -1], [-1, 0], [-1, 1],
    [ 0, -1],          [ 0, 1],
    [ 1, -1], [ 1, 0], [ 1, 1],
  ]
  ns = []
  dirs.each do |(i,j)|
    dx, dy = x+i, y+j
    if (0 <= dx  && dx < @h) && (0 <= dy && dy < @w)
      ns << [dx, dy]
    end
  end
  ns
end

def inc octs
  octs.map do |line|
    line.map do |n|
      n + 1
    end
  end
end

def flash x, y, input
  @flashes += 1
  input[x][y] = 0 # flashed
  ns = neighbors x, y
  # increment neighbors
  ns.each do |(i,j)|
    if input[i][j] != 10 && input[i][j] != 0
      input[i][j] += 1
      if input[i][j] == 10
        flash i, j, input
      end
    end
  end
end

@flashes = 0
os = input.map { |x| x.chars.map { |c| c.to_i }}
i = 0
loop do
  os = inc os
  os.each_with_index do |line, x|
    line.each_with_index do |o, y|
      if o == 10
        flash x, y, os
      end
    end
  end
  i += 1

  if i == 100
    p "Part 1: #{@flashes}"
  end

  if os.all? { |x| x.all? { |c| c == 0 } }
    p "Part 2: #{i}"
    break
  end
end
