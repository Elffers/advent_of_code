require 'set'
input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day15test.in").split("\n").map { |x| x.chars.map { |c| c.to_i }}
input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day15.in").split("\n").map { |x| x.chars.map { |c| c.to_i }}

# vertical and horizontal only
def adj x, y, input
  h = input.size
  w = input.first.size
  dirs = [
    [-1, 0], [1, 0], [0, -1], [0, 1]
  ]
  ns = []
  dirs.each do |(i,j)|
    dx, dy = x+i, y+j
    if (0 <= dx && dx < h) && (0 <= dy && dy < w)
      ns << [dx, dy]
    end
  end
  ns
end

def shortest_path input
  h = input.size
  w = input.first.size
  memo = Array.new(h) { Array.new w }
  memo[0][0] = 0
  (0...w).each do |j|
    next if j == 0
    memo[0][j] = memo[0][j-1] + input[0][j]
  end
  (0...h).each do |i|
    next if i == 0
    memo[i][0] = memo[i-1][0] + input[i][0]
  end

  (1...h).each do |i|
    (1...w).each do |j|
      ns = adj i, j, input
      v = ns.map { |(x, y)| memo[x][y] }
      memo[i][j] = input[i][j] + v.compact.min
      p "MEMO COST: #{memo[i][j]}, #{[i,j] }"
    end
  end
  pp memo
  memo[h-1][w-1]
end

def inc input, i
  x = (1..9).to_a
  input.map do |r|
    x = (r+i) %9
    if x == 0
      x = 9
    end
    x
  end
end

def expand input
  res = []

  i = 0
  while i < 5
  input.each do |row|
    new_row = []
    (0..4).each do |j|
      new_row.concat(inc row, i+j)
    end
    res << new_row
  end
  i += 1
  end
  res
end

input2 = expand input
def extract_min queue, dist
  costs = queue.map.with_index do |n, i|
    cost = dist[n.first][n.last]
    [cost, i]
  end
  _, idx = costs.min_by { |(cost, i)| cost }
  queue[idx]
end

def extract_min2 queue
  priority = queue.keys.min
  v = queue[priority].shift
  [v, priority]
end

require "pp"

def dijkstra weights
  dist = weights.map do |row|
    row.map do |d|
      Float::INFINITY
    end
  end

  dist[0][0] = 0

  seen = Set.new
  prev = Hash.new
  # TODO use priority queue
  queue = []
  # queue = Hash.new { |h, k| h[k] = [] }
  d = weights.size
  (0...d).each do |i|
    (0...d).each do |j|
      # priority = dist[i][j]
      # queue[priority] << [i, j]
      queue << [i, j]
    end
  end

  while !queue.empty?
    p queue.size
    u = extract_min queue, dist
    # queue[p].delete u
    # if queue[p].empty?
    #   queue.delete p
    # end
    queue.delete u
    seen << u

    x = u.first
    y = u.last
    vs = adj x, y, weights

    vs.each do |v|
      i, j = v
      if !seen.include? [i,j] # TODO
      cost = dist[x][y] + weights[i][j]
      # p "COST: #{cost}, #{[i,j] }"
      if cost < dist[i][j]
        dist[i][j] = cost # decrease-key
        # p "ALT COST for #{[i,j]}: #{dist[i][j]}"
        prev[v] = u
      end
      end
    end
  end
  # dist.each do |d|
  #   p d
  # end

  path = Hash.new
  costs = []
  dest = [d-1, d-1]
  while dest
    cost = weights[dest.first][dest.last]
    path[dest] = cost
    costs.unshift cost
    dest = prev[dest]
  end

  # pp path.sort_by { |k, v| k}
  dist[d-1][d-1]
end

# p "Part 1: #{dijkstra input}"

p "Part 2: #{dijkstra input2}"
# test input:
# real	0m0.600s
# user	0m0.583s
# sys	0m0.013s
