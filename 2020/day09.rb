require 'set'

input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day09.in").split("\n").map { |x| x.to_i }
# input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day09test.in").split("\n").map { |x| x.to_i }

x, y = 0, 25
# x, y = 0, 5 # test
window = input[x,y]
queue = input[y, input.size]
# p queue.size

def sum_in? n, window

  set = Set.new(window)

  set.any? do |x|
    complement = n-x
    set.include? complement
  end
end

while !queue.empty?
  curr = queue.shift
  if !sum_in? curr, window
    p curr
    break
  end
  window.shift
  window << curr
end

