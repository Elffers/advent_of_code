require 'set'

weights = File.readlines("../inputs/day24.in").map { |x| x.strip.to_i }
# weights = [1, 2, 3, 4, 5, 7, 8, 9, 10, 11]
# p weights.size

target_weight = (weights.reduce(:+) / 4) #512, #384
# p target_weight

# brute force
subsets = Set.new
(3...24).each do |n|
  combos = weights.combination(n)
  combos.each do |combo|
    sum = combo.reduce(:+)
    if sum == target_weight
      p combo
      subsets << combo
    end
  end
end
p subsets

sorted = weights.sort

loads = Set.new
smallest_loads = Hash.new { |h, k| h[k] = Set.new }

subsets.to_a.combination(3).each do |ss|
  if ss.reduce(:+).sort == sorted
    fewest = ss.min_by { |l| l.size }
    smallest_loads[fewest.size] << fewest
    loads << ss
  end
end
p loads
puts

min_pkgs = smallest_loads.keys.min
quantum_entanglements = smallest_loads[min_pkgs].map { |x| x.reduce(:*) }
p quantum_entanglements

# def subset_sum(nums, target, partial=[], subsets = {})
#   if partial.empty?
#     sum = 0
#   else
#     sum = partial.reduce(:+)
#   end

#   if sum == target
#     # p partial
#     subsets[partial] = true
#     # p subsets
#   end

#   if sum >= target
#     return
#   end

#   nums.each_with_index do |n, i|
#     remaining = nums.drop(i+1)
#     subset_sum(remaining, target, partial + [n], subsets)
#   end

#   subsets
# end

# p subset_sum(weights, target_weight).keys
#
# hack involving only returning the first few combos
a = [[1, 79, 103, 107, 109, 113],
     [1, 89, 97, 103, 109, 113],
     [3, 79, 101, 107, 109, 113],
     [3, 83, 97, 107, 109, 113],
     [3, 83, 101, 103, 109, 113],
     [3, 89, 97, 101, 109, 113],
     [3, 89, 97, 103, 107, 113],
     [3, 89, 101, 103, 107, 109],
     [5, 83, 101, 103, 107, 113],
     [5, 89, 97, 101, 107, 113],
     [7, 73, 103, 107, 109, 113],
]

b = [
  [59, 103, 109, 113],
  [61, 101, 109, 113],
  [61, 103, 107, 113],
  [67, 97, 107, 113],
  [67, 101, 103, 113],
  [67, 101, 107, 109],
  [71, 97, 103, 113],
  [71, 97, 107, 109],
  [71, 101, 103, 109],
  [73, 89, 109, 113],
  [73, 97, 101, 113],
  [73, 101, 103, 107],
  [79, 83, 109, 113],
  [79, 89, 103, 113],
  [79, 89, 107, 109],
  [79, 97, 101, 107],
  [83, 89, 103, 109],
  [83, 97, 101, 103],
]
