input = File.read("/Users/hhhsu/sandbox/aoc/2022/inputs/day01.in")
elves = input.split("\n\n").map { |x| x.split("\n") }

sums = elves.map do |cals|
  cals.map { |cal| cal.to_i }.sum
end

sums.sort!

p "Part 1: #{sums.last}"
p "Part 2: #{sums[-3..-1].sum}"
