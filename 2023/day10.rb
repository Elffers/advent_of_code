require 'set'

input = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day10.in").split("\n")
# input = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day10_test.in").split("\n")

start = []
input.each.with_index do |row, i|
  row.chars.each.with_index do |val, j|
    if val == "S"
      start << i
      start << j
    end
  end
end

# returns the pipes connected to pos
def find_loop pos, graph
  width = graph.first.size
  height = graph.size

  x, y = pos
  val = graph[x][y]
  ns = []
  north = [x-1, y]
  south = [x+1, y]
  east = [x, y+1]
  west = [x, y-1]
  case val
  when  "S"
    n = graph[x-1][y]
    s = graph[x+1][y]
    e = graph[x][y+1]
    w = graph[x][y-1]

    ns << north if x-1 >= 0 && ["|", "7", "F"].include?(n)
    ns << south if x+1 < height && ["|", "J", "L"].include?(s)
    ns << east  if y+1 < width && ["-", "7", "J"].include?(e)
    ns << west  if y-1 >= 0 && ["-", "F", "L"].include?(w)
  when  "|"
    ns << north if x-1 >= 0
    ns << south if x+1 < height
  when  "-"
    ns << east if y+1 < width
    ns << west if y-1 >= 0
  when  "L"
    ns << north if x-1 >= 0
    ns << east if y+1 < width
  when  "J"
    ns << north if x-1 >= 0
    ns << west if y-1 >= 0
  when  "7"
    ns << south if x+1 < height
    ns << west if y-1 >= 0
  when  "F"
    ns << south if x-1 >= 0
    ns << east if y+1 < width
  end
  ns
end

# find all coordinates in the loop
def bfs start, graph
  steps = {start => 0} # also tracks if a node was visited
  i = 1
  queue = [start]

  while !queue.empty?
    frontier = []
    queue.each do |pos|
      find_loop(pos, graph).each do |n|
        if steps[n].nil?
          steps[n] = i
          frontier << n
        end
      end
    end
    queue = frontier
    i += 1
  end
  steps
end

# vertical and horizontal only
def adj x, y, h, w
  ns = []
  [ [-1, 0], [1, 0], [0, -1], [0, 1] ].each do |i, j|
    dx, dy = x+i, y+j
    # allow for neighbors outside the bounds of the graph so we know if we can
    # escape the loop in the case that the loop as at the edge
    if (-1 <= dx && dx < h+1) && (-1 <= dy && dy < w+1)
      ns << [dx, dy]
    end
  end
  ns
end

# can reach outside the bounds of the graph
def can_escape? x, y, h, w
  x > h || y > w || x < 0 || y < 0
end

# use bfs to try to reach edge of graph, or find all the coordinates reachable
# from inside the loop (i.e. all coordinates inside the loop)
def find_enclosed? start, graph, pipes
  w = graph.first.size
  h = graph.size
  parents = {}
  parents[start] = nil
  frontier = [start]

  while !frontier.empty?
    frontier.each do |pos|
    queue = []
      x, y = pos
      # north = [x-1, y]
      # south = [x-1, y]
      # east = [x, y+1]
      # west = [x, y-1]

      # If node is part of loop, follow pipe and enqueue everything on the
      # same "side" of loop as node. DFS?
      if pipes[pos]
        px, py = parents[pos]
        val = graph[x][y]
        case val
        when "|"
          frontier << north
          frontier << south

        when "-"
        when "L"
        when "J"
        when "7"
        when "F"
        end
      end

      # ns = adj(x, y, h, w)
      # ns.each do |n|
      #   i, j = n
      #   if can_escape?(i, j)
      #     return false
      #   end

      #   if parents[n].nil? # TODO bug if hit start?
      #     parents[n] == pos
      #     # determine frontier
      #     if pipes[n] # hit pipe in loop, follow loop
      #       val = graph[i][j]
      #       case val
      #       when "|"
      #       end
      #     else
      #       # determine frontier based on parent
      #       frontier << n
      #     end

      #   end
      # end
    end
    queue = frontier
  end
  seen
end

steps = bfs(start, input)
enclosed = inside_loop? start, input, steps

p "Part 1: #{steps.values.max}"
p "Part 2: #{enclosed.count}"
