input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day03.in").split("\n").map { |x| x.chars }.transpose
g = ""
e = ""
input.map do |x|
  a = x.count { |i| i == "1" }
  b = x.count { |i| i == "0" }
  if a > b
    g += "1"
    e += "0"
  else
    g += "0"
    e += "1"
  end
end

p [g, e].map { |x| x.to_i(2) }.reduce(:*)

