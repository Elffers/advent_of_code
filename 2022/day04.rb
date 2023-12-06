input = File.read("/Users/hhhsu/sandbox/aoc/2022/inputs/day04.in").split("\n")

def contains? ranges
  min1, min2, max1, max2 = ranges

  (min1 <= min2 && max1 >= max2) ||
  (min2 <= min1 && max2 >= max1)
end

def overlap? ranges
  min1, min2, max1, max2 = ranges

  if min1 <= min2
    max1 >= min2
  elsif min2 <= min1
    max2 >= min1
  end
end

count = 0
count2 = 0

input.each do |line|
  /(?<min1>\d+)-(?<max1>\d+),(?<min2>\d+)-(?<max2>\d+)/ =~ line
  ranges  = [min1, min2, max1, max2].map { |x| x.to_i }

  if contains? ranges
    count += 1
  end

  if overlap? ranges
    count2 += 1
  end
end

p "Part1: #{count}"
p "Part2: #{count2}"
