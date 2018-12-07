require 'set'

weights = File.readlines("../inputs/day24.in").map { |x| x.strip.to_i }
weights = [1, 2, 3, 4, 5, 7, 8, 9, 10, 11]

target_weight = (weights.reduce(:+) / 3) #512
p target_weight


def subset_sum(nums, target, partial=[], subsets = {})
  if partial.empty?
    sum = 0
  else
    sum = partial.reduce(:+)
  end

  if sum == target
    # p partial
    subsets[partial] = true
    # p subsets
  end

  if sum >= target
    return
  end

  nums.each_with_index do |n, i|
    remaining = nums.drop(i+1)
    subset_sum(remaining, target, partial + [n], subsets)
  end

  subsets
end

p subset_sum(weights, target_weight).keys

