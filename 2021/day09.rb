input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day09test.in").split("\n").map { |x| x.chars.map { |c| c.to_i }}
# input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day09.in").split("\n").map { |x| x.chars.map { |c| c.to_i }}

@h = input.size
@w = input.first.size

def neighbors x, y, input
  ns = []
  if x - 1 >= 0
    ns << input[x-1][y]
  end
  if y - 1 >= 0
    ns << input[x][y-1]
  end
  if x + 1 < @h
    ns << input[x+1][y]
  end
  if y + 1 < @w
    ns << input[x][y+1]
  end
  ns
end

lp = []

input.each_with_index do |line, x|
  line.each_with_index do |n, y|
    ns = neighbors x, y, input
    if ns.min > n
      lp << n
    end
  end
end

p "Part 1: #{lp.map { |x| x+1 }.sum}"
