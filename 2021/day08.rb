input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day08test.in").split("\n")
input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day08.in").split("\n")

# [["0", 6], ["1", 2], ["2", 5], ["3", 5], ["4", 4], ["5", 5], ["6", 6], ["7", 3], ["8", 7], ["9", 6]]
# ["1", 2]
# ["4", 4]
# ["7", 3]
# ["8", 7]]

count = 0
input.each do |x|
  b = x.split(" | ")
  c = b.last.split(" ").select {|x| x.length == 2 || x.length == 4 || x.length == 3 || x.length == 7 }
  count += c.size
end

p "Part 1: #{count}"
