require 'set'
require 'pp'
input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day7.in").map { |x| x.strip }
# input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day7test.in").map { |x| x.strip }

graph = Hash.new { |h, k| h[k] = [] }
reversed = Hash.new { |h, k| h[k] = [] }
# graph["E"] = []

input.each do |line|
  # Step C must be finished before step A can begin.
  /^Step ([A-Z]).+ step ([A-Z])/ =~ line
  graph[$1] << $2
  graph[$2]
  reversed[$2] << $1
  reversed[$1]
end

# pp graph
# pp reversed
# {"C"=>["A", "F"], "A"=>["B", "D"], "B"=>["E"], "D"=>["E"], "F"=>["E"]}

def find_roots(graph, reversed)
  roots = []
  graph.keys.each do |key|
    roots << key if reversed[key].empty?
  end
  roots.sort
end

roots = find_roots(graph, reversed)
# p "root: #{roots.sort}"

order = []
current = roots.shift

order << current
to_visit = roots

while current
  edges = graph[current]
  to_visit.concat edges
  to_visit = to_visit.uniq.sort

  # p "to visit: #{to_visit.join}"
  node = nil
  loop do
    node = to_visit.shift
    preceding = reversed[node]

    if preceding.all? { |x| order.include? x }
      order << node
      break
    else
      to_visit << node
    end
  end

  current = node

  # puts "order: #{order.join}\n\n"
end
puts "Part 1: #{order.join}\n\n"
