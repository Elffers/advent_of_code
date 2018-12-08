input = File.read("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day8.in").strip.split(" ").map { |x| x.to_i }
# input =  [2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2]

def build_tree input
  sum = 0
  value = 0

  c = input.shift
  mds = input.shift
  children = Array.new c

  c.times do |i|
    s, v = build_tree input
    children[i] = v
    sum += s
  end

  mds.times do
    md = input.shift
    if c == 0
      value += md
    end
    value += children[md-1] if children[md-1]
    sum += md
  end

  [sum, value]
end

sum, value = build_tree input
p "Part 1: #{sum}"
p "Part 2: #{value}"
