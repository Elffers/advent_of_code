input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day07test.in").split(",").map { |x| x.to_i }
input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day07.in").split(",").map { |x| x.to_i }
x, y = input.minmax
p [x,y]

ans = (x..y).map do |i|
  s = input.map do |p|
    (p-i).abs
  end.sum
end.min

p ans
