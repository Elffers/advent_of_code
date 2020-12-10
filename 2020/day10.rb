input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day10.in").split("\n").map { |x| x.to_i }
# input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day10test.in").split("\n").map { |x| x.to_i }

device = input.max + 3
input << device
input << 0
p device
d1, d3 = 0,0

adapters = input.sort

adapters.each_cons(2) do |pair|
  p pair
  x, y = pair
  diff = y-x

  d1 += 1 if diff == 1
  d3 += 1 if diff == 3
  if !(diff == 1) && !(diff == 3)
    p "error: #{pair}"
  end
end
p "counts: #{[d1, d3]}"
p d1 * d3

