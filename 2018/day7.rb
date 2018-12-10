require 'set'
require 'pp'
input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day7.in").map { |x| x.strip }
input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day7test.in").map { |x| x.strip }

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

# pp graph
# pp inverse
# {"C"=>["A", "F"], "A"=>["B", "D"], "B"=>["E"], "D"=>["E"], "F"=>["E"]}

def find_roots(graph, inverse)
  roots = []
  graph.keys.each do |key|
    roots << key if inverse[key].empty?
  end
  # p "roots: #{roots.sort.join}"
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

def work_together graph, inverse, worker_count
  roots = find_roots(graph, inverse)
  done = []
  queue = roots
  t = 0
  workers = Array.new worker_count, nil

  while !queue.empty?
    # queue = queue.uniq.sort

    t += 1
    workers.each_with_index do |work, i|
      if !work.nil?
        work[:count] -= 1
        if work[:count] == 0
          done << work[:edge]
          workers[i] = nil
        end
      end
    end

    # distribute work
    while workers.any? { |x| x.nil? }
    edge = queue.shift
    p "queue edge: #{edge}"

    edges = graph[edge]
    queue.concat edges if edges
    queue = queue.uniq.sort

    # enqueue any dependencies
    depends_on = inverse[edge]

    if depends_on.all? { |x| done.include? x }
      work = {
        edge: edge,
        count: edge.ord - 65 # 5 -- off by one?
      }
      # if can be worked, find worker to process
      i = workers.find_index { |w| w.nil? }
      workers[i] = work
      # if no worker is free, enqueue
    else
      queue << edge
    end
    p "Workers: #{workers}"
    p "Queue: #{queue.join}"
    p "tick: #{t}"
    p "done: #{done.join}"
    puts
    end

  end
  return t

end

# graph = {"C"=>["A", "F"], "A"=>["E"], "F"=>["E"]}
# inverse = {"A"=>["C"], "F"=>["C"], "E"=>["A", "F"]}
p work_together graph, inverse, 2

# puts "Part 1: #{order_steps graph, inverse}\n\n"
