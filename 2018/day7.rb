require 'set'
require 'pp'
input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day7.in").map { |x| x.strip }
# input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day7test.in").map { |x| x.strip }

graph = Hash.new { |h, k| h[k] = [] }
inverse = Hash.new { |h, k| h[k] = [] }
# graph["E"] = []

input.each do |line|
  # Step C must be finished before step A can begin.
  /^Step ([A-Z]).+ step ([A-Z])/ =~ line
  graph[$1] << $2
  graph[$2]
  inverse[$2] << $1
  inverse[$1]
end

pp graph
# pp inverse
# {"C"=>["A", "F"], "A"=>["B", "D"], "B"=>["E"], "D"=>["E"], "F"=>["E"]}

def find_roots(graph, inverse)
  roots = []
  graph.keys.each do |key|
    roots << key if inverse[key].empty?
  end
  p "roots: #{roots.sort.join}"
  roots.sort
end

# Part 1
def order_steps graph, inverse
  roots = find_roots(graph, inverse)

  order = []
  current = roots.shift

  order << current
  queue = roots

  while current
    edges = graph[current]
    queue.concat edges
    queue = queue.uniq.sort

    edge = nil

    loop do
      edge = queue.shift
      depends_on = inverse[edge]

      if depends_on.all? { |x| order.include? x }
        order << edge
        break
      else
        queue << edge
      end
    end

    current = edge
  end

  order.join
end

puts "Part 1: #{order_steps graph, inverse}\n\n"
