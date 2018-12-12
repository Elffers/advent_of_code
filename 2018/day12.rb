require 'pp'
input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day12.in").map { |x| x.strip }
# input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day12test.in").map { |x| x.strip }

initial = input.first.split(": ").last

pots = {}
initial.chars.each_with_index do |char, i|
  pots[i] = char
end

RULES = {}

input[2,input.size - 1].each do |x|
  rule, val = x.split(" => ")
  RULES[rule] = val
end

def nextg(pots)
  next_gen = {}
  min = pots.keys.min
  max = pots.keys.max
  # Have to add padding here to account for rule matching at the ends of
  # current generation
  pots[min-2] = "."
  pots[min-1] = "."
  pots[max+2] = "."
  pots[max+1] = "."

  pots.each do |i, v|
    pattern = (i-2..i+2).map do |pot|
      if !pots[pot]
        next_gen[pot] = "."
        "."
      else
        pots[pot]
      end
    end.join

    val = RULES[pattern]
    if val
      next_gen[i] = val
    else
      next_gen[i] = "."
    end
  end

  next_gen
end

i = 0
20.times do
  i += 1
  if i % 1000 == 0
    p i
  end
  pots = nextg(pots)
  # puts pots.sort_by { |k, v| k }.map { |n| n.last }.join
end

sum = 0
pots.each do |k, v|
  if v == "#"
    sum += k
  end
end
p "Part 1: #{sum}"
