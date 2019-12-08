require 'pp'

pwd = File.read("/Users/hhh/JungleGym/advent_of_code/2019/inputs/day08.in").strip

dim = 25*6
counts = {}

pwd.chars.each_slice(dim) do |layer|
  count = layer.count("0")
  counts[count] = layer.join
end

target = counts.keys.min
p "Part 1: #{counts[target].count("1")* counts[target].count("2")}"
