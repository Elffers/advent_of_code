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
# K)YOU
# I)SAN
# ]

graph = {}
reverse = {}

input.each do |line|
  x, y = line.split(')')
  graph[y] = x
  reverse[x] = y
end

# leaves = graph.keys - (graph.keys & graph.keys)
root = []
reverse.each do |k, v|
  if !graph.keys.include? k
    root = k
  end
end

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

# part 2 is find least common parent
you_path = []
node = "YOU"
while !node.nil?
  node = graph[node]
  you_path << node
end

san_path = []
node = "SAN"
until you_path.include? node
  node = graph[node]
  san_path << node
end
# p "common ancestor: #{node}"

p "Part 2: #{you_path.index(node) + san_path.index(node)}"
