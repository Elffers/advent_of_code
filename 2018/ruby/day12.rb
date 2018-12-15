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

  sum = 0
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
      if val == "#"
        sum += i
      end
    else
      next_gen[i] = "."
    end
  end

  [next_gen, sum]
end

sum = 0
108.times do |i|
  pots, next_sum = nextg(pots)
  if i == 20
    p "Part 1: #{sum}"
  end
  sum = next_sum
end

# diff is 52, starts repeating after 108 iterations
sum += (50000000000 - 108) * 52
p "Part 2: #{sum}"
