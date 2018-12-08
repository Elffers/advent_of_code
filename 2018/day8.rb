input = File.read("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day8.in").strip.split(" ").map { |x| x.to_i }
# input =  [2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2]

def build_tree input
  sum = 0
  c = input.shift
  mds = input.shift

  c.times do
    sum += (build_tree input)
  end

  mds.times do
    md = input.shift
    sum += md
  end

  sum
end

p build_tree input
