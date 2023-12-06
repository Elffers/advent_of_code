input = File.read("/Users/hhhsu/sandbox/aoc/2022/inputs/day12.in").split("\n")

graph = {}
start = nil
dest = nil
starts = []

input.each.with_index do |row, i|
  row.each_char.with_index do |char, j|
    if char == "S"
      start = [i, j]
      char = "a"
    elsif char == "E"
      dest = [i, j]
      char = "z"
    elsif char == "a"
      starts << [i, j]
    end
    graph[[i, j]] = char
  end
end

# vertical and horizontal only
def adj pos, graph
  x, y = pos
  ns = []
  [ [-1, 0], [1, 0], [0, -1], [0, 1] ].each do |i, j|
    dx, dy = x+i, y+j
    val = graph[[dx, dy]]
    if val && (val <= graph[pos].next || val == graph[pos])
      ns << [dx, dy]
    end
  end
  ns
end

def bfs start, graph, dest
  steps = {start => 0}
  i = 0
  queue = [start]
  while !queue.empty?
    frontier = []
    queue.each do |pos|
      if pos == dest
        return i
      end
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
end

p "Part 1: #{bfs(start, graph, dest)}"

distances = starts.map do |start|
  bfs(start, graph, dest)
end

p "Part 2: #{distances.compact.min}"
