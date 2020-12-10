adapters = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day10.in").split("\n").map { |x| x.to_i }

device = adapters.max + 3
adapters << device
adapters << 0

d1, d3 = 0,0

adapters.sort.each_cons(2) do |x, y|
  diff = y-x

  d1 += 1 if diff == 1
  d3 += 1 if diff == 3
end

p "part 1: #{d1 * d3}"

# NOTE: Traditional DFS is too slow
#
# graph = Hash.new { |h, k| h[k] = [] }
# adapters.each do |x|
#   choices = [x+1, x+2, x+3]
#   choices.each do |choice|
#     if adapters.include? choice
#       graph[x] << choice
#     end
#   end
# end
# p graph

# target = device
# queue = graph[0]
# combos = 0

# # dfs
# while !queue.empty?
#   curr = queue.shift
#   if curr == target
#     combos += 1
#   else
#     queue.concat(graph[curr])
#   end
# end

# p "part 2: #{combos}"


# Use dynamic programming to cache the number of paths from each joltage node.
# This will recursively populate the cache bottom-up for each adapter with the
# number of paths to the terminus, which will be the sum of the paths to the
# terminus for each child node.

combos = Hash.new do |paths, j|
  choices = [j+1, j+2, j+3]
  child_adapters = choices.select { |c| adapters.include? c }

  # sum of number of paths for each child node
  count = child_adapters.map { |a| paths[a] }.sum
  paths[j] = count
end

# at the terminus, there is one path
combos[device] = 1

p "part 2: #{combos[0]}"

