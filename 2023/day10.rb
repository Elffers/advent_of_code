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

def adj pos, graph
  width = graph.first.size
  length = graph.size

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
    ns << south if x+1 < length && ["|", "J", "L"].include?(s)
    ns << east  if y+1 < width && ["-", "7", "J"].include?(e)
    ns << west  if y-1 >= 0 && ["-", "F", "L"].include?(w)
  when  "|"
    ns << north if x-1 >= 0
    ns << south if x+1 < length
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
    ns << south if x+1 < length
    ns << west if y-1 >= 0
  when  "F"
    ns << south if x-1 >= 0
    ns << east if y+1 < width
  end
  ns
end

def bfs start, graph
  steps = {start => 0} # also tracks if a node was visited
  i = 1
  queue = [start]

  while !queue.empty?
    frontier = []
    queue.each do |pos|
      adj(pos, graph).each do |n|
        if steps[n].nil?
          steps[n] = i
          frontier << n
        end
      end
    end
    queue = frontier
    i += 1
  end
  steps.values.max
end

p "Part 1: #{bfs(start, input)}"
