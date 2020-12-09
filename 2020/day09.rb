require 'set'

input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day09.in").split("\n").map { |x| x.to_i }

x, y = 0, 25
window = input[x,y]
queue = input[y, input.size]

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
    p "part 1: #{curr}"
    break
  end
  window.shift
  window << curr
end

target = curr

x = 0
y = x + 2

while y < input.size
  window = input[x..y]
  # p window
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

