input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day03.in").split("\n").map { |x| x.chars }.transpose
p input
g = input.map do |x|
  a = x.count { |i| i == "1" }
  b = x.count { |i| i == "0" }
  if a > b
    "1"
  else
    "0"
  end
end.join.to_i(2)

e = input.map do |x|
  a = x.count { |i| i == "1" }
  b = x.count { |i| i == "0" }
  if a < b
    "1"
  else "0"
  end
end.join.to_i(2)

p g*e

