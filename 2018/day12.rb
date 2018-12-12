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
# pp RULES

def nextg(pots)
  next_gen = {}
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

20.times do
  pots = nextg(pots)
  puts pots.sort_by { |k, v| k }.map { |n| n.last }.join
end

pp pots

sum = 0
pots.each do |k, v|
  if v == "#"
    sum += k
  end
end
p sum
# 2929 too low?
# 2959 too low
