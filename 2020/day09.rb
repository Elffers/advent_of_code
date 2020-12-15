require 'set'

input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day09.in").split("\n").map { |x| x.to_i }

def sum_in? n, window
  set = Set.new(window)

  set.any? do |x|
    complement = n-x
    set.include? complement
  end
end

def part1 input
  x, y = 0, 25
  window = input[x,y]
  queue = input[y, input.size]

  while !queue.empty?
    curr = queue.shift
    if !sum_in? curr, window
      return curr
    end
    window.shift
    window << curr
  end
end

target = part1 input
p "part 1: #{target}"

x = 0
y = x + 2

while y < input.size
  window = input[x..y]
  sum = window.reduce(:+)
  if sum == target
    p "part 2: #{window.min + window.max}"
    break
  end
  if sum < target
    y += 1
  end
  if sum > target
    x += 1
    y = x + 1
  end
end

