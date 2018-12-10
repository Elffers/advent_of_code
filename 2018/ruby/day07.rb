input = File.readlines("./inputs/day7.in").map { |x| x.strip }

graph = Hash.new { |h, k| h[k] = [] }
inverse = Hash.new { |h, k| h[k] = [] }

# Populate graph and inverse dependencies
input.each do |line|
  # Step C must be finished before step A can begin.
  /^Step ([A-Z]).+ step ([A-Z])/ =~ line
  graph[$1] << $2
  graph[$2]
  inverse[$2] << $1
  inverse[$1]
end

def find_roots(graph, inverse)
  roots = []
  graph.keys.each do |key|
    roots << key if inverse[key].empty?
  end
  roots.sort
end

# Part 1
def order_steps graph, inverse
  roots = find_roots(graph, inverse)

  done = []
  current = roots.shift

  done << current
  queue = roots

  while current
    edges = graph[current]
    queue.concat edges
    queue = queue.uniq.sort

    edge = nil

    loop do
      edge = queue.shift
      depends_on = inverse[edge]

      if depends_on.all? { |x| done.include? x }
        done << edge
        break
      else
        queue << edge
      end
    end

    current = edge
  end

  done.join
end

# Part 2
def work_together graph, inverse, worker_count
  roots = find_roots(graph, inverse)
  avail = roots
  done = []
  queue = []
  t = 0

  # Populate initial queue
  avail.each do |edge|
    deps = graph[edge]
    queue.concat deps
  end

  queue = queue.uniq.sort

  # Edges currently being processed
  processing = Array.new worker_count, nil

  # Time left each worker has on given edge
  workers = Array.new worker_count, 0

  while !queue.empty? || !processing.compact.empty?
    # Decrement timer on each worker if they are busy
    workers.each_with_index do |timer, i|
      workers[i] -= 1 if timer > 0
      if workers[i] == 0
        processed = processing[i]
        done << processed
        processing[i] = nil

        # Recalculate what is available for processing
        queue.each do |edge|
          depends_on = inverse[edge]
          if depends_on.all? { |x| done.include? x }
            avail << edge
            queue.delete edge
          end
        end
      end
    end

    # Assign any available to work to any unoccupied worker
    while !avail.empty?
      if workers.any? { |w| w.zero? }
        edge = avail.shift

        # Repopulate queue with next edges
        edges = graph[edge]
        queue.concat edges if edges
        queue = queue.uniq.sort

        # "A".ord - 4 = 1 + 60
        timer = edge.ord - 4
        i = workers.find_index { |w| w.zero? }

        # Assign work and store which edge is being processed
        processing[i] = edge
        workers[i] = timer
      end
    end

    t += 1
  end

  # p "done: #{done.join}"

  t - 1
end


p "Part 1: #{order_steps graph, inverse}"
p "Part 2: #{work_together graph, inverse, 5}"
