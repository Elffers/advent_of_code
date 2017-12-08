require 'pp'
# input = File.readlines('day7_test.in').map { |x| x.strip }
input = File.readlines('day7.in').map { |x| x.strip }

programs = Hash.new

input.each do |line|
  root, leaves = line.split(" -> ")
  k = root.scan(/\w+/).first
  if !leaves.nil?
    leaves = leaves.split(",").map { |x| x.strip }
    leaves.each do |leaf|
      programs[leaf] = k
    end
  end
end

# pp programs

# current = programs.first.first

# until current.nil?
#   root = current
#   current = programs[current]
# end

# p root: root

# part 2
weights = Hash.new

input.each do |line|
  root = line.split(" -> ").first
  k = root.scan(/\w+/).first
  weights[k] = root.scan(/\d+/).first.to_i
end

# pp weights: weights

towers = Hash.new
input.each do |line|
  root, leaves = line.split(" -> ")
  k = root.scan(/\w+/).first
  if !leaves.nil?
    leaves = leaves.split(",").map { |x| x.strip }
    towers[k] = leaves
  else
    towers[k] = nil
  end
end
# pp towers: towers

current = programs.first.first

until current.nil?
  root = current
  current = programs[current]
end

p root: root

def build_tree root, weights, towers
  tree = Hash.new
  leaves = towers[root]
  if leaves.nil?
    tree[root] = [weights[root], nil ]
  else
    children = leaves.map do |leaf|
      build_tree leaf, weights, towers
    end
    tree[root] = [ weights[root], children ]
  end
  tree
end

pp build_tree root, weights, towers

def build_totals root, weights, towers
  leaves = towers[root]
  if leaves.nil?
    weights[root]
  else
    leaf_weights = leaves.map do |leaf|
      build_totals leaf, weights, towers
    end
    # if leaf_weights.uniq.length != 1
      p xroot: root, xleaf_weights: leaf_weights
    # end
    leaf_weights.reduce(:+) + weights[root]
  end
end

# pp build_totals root, weights, towers

def find_different weights
  counts = Hash.new 0
  weights.each do |x|
    counts[x] += 1
  end
  k, _ = counts.rassoc 1
  k
end

leaves = towers[root]
leaf_weights = leaves.map { |leaf| build_totals leaf, weights, towers }

while leaf_weights.uniq.length > 1
  # pp root: root, leaf_weights: leaf_weights

  diff_weight = find_different leaf_weights
  i = leaf_weights.index(diff_weight)

  old_weights = leaf_weights
  old_leaves = leaves

  root = leaves[i]
  leaves = towers[root]
  leaf_weights = leaves.map { |leaf| build_totals leaf, weights, towers }
end

p final: [root, weights[root]], old_leaves: old_leaves, old_weights: old_weights, leaf_weights: leaf_weights, leaves: leaves

