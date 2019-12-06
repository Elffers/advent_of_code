require 'pp'

input = File.readlines("./inputs/day06.in").map { |x| x.strip }
# input = %w[
# COM)B
# B)C
# C)D
# D)E
# E)F
# B)G
# G)H
# D)I
# E)J
# J)K
# K)L
# ]

graph = {}

input.each do |line|
  x, y = line.split(')')
  graph[y] = x
end

# leaves = graph.keys - (graph.keys & graph.keys)
# roots = []
# graph.each do |k, v|
#   if !graph.keys.include? k
#     roots << k
#   end
# end

# p leaves
# p roots

orbits = 0
graph.each do |node, direct|
  count = 0
  while !graph[node].nil?
    count += 1
    node = graph[node]
  end
  orbits += count
end

p "Part 1: #{orbits}"
# 453028
