input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day03.in").split("\n")

g = ""
input.map { |i| i.chars }.transpose.map do |x|
  a = x.count "1"
  b = x.count "0"
  if a > b then g += "1" else g += "0" end
end
e = g.tr "10","01"
p "Part 1: #{[g, e].map { |x| x.to_i(2) }.reduce(:*)}"

def find_oxy xs, pos
  return xs.first if xs.length == 1
  bits = xs.map { |x| x[pos] }
  x = bits.count "1"
  y = bits.count "0"
  b = if x >= y then "1" else "0" end
  xs = xs.select { |n| n[pos] == b }
  pos += 1
  find_oxy xs, pos
end

def find_co2 xs, pos
  return xs.first if xs.length == 1
  bits = xs.map { |x| x[pos] }
  x = bits.count "1"
  y = bits.count "0"
  b = if x < y then "1" else "0" end
  xs = xs.select { |n| n[pos] == b }
  pos += 1
  find_co2 xs, pos
end

oxy = find_oxy input, 0
co2 = find_co2 input, 0
p "Part 2: #{[oxy, co2].map { |x| x.to_i(2) }.reduce(:*)}"
