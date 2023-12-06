input = File.read("/Users/hhhsu/sandbox/aoc/2022/inputs/day03.in").split("\n")

priorities = ("a".."z").to_a + ("A".."Z").to_a

sum = input.map do |items|
  i = items.length/2
  c1 = items[0...i]
  c2 = items[i..-1]
  x = c1.chars.intersection(c2.chars)
  priorities.index(x.first) + 1
end.sum

p "Part 1: #{sum}"

sum2 = 0
input.each_slice(3) do |(a, b, c)|
  x = a.chars.intersection(b.chars).intersection(c.chars)
  sum2 += priorities.index(x.first) + 1
end

p "Part 2: #{sum2}"
