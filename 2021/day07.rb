input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day07.in").split(",").map { |x| x.to_i }

x, y = input.minmax
ans = (x..y).map do |i|
  fuel = input.map do |p|
    d = (p-i).abs # just this for part 1
    (1..d).sum # part 2
  end.sum
end.min

p ans
