require 'set'

maze = [
  [ 1, 1, 1, 1, 1, 0, 0, 1, 1, 1 ],
  [ 0, 1, 1, 1, 1, 1, 0, 1, 0, 1 ],
  [ 0, 0, 1, 0, 1, 1, 1, 0, 0, 1 ],
  [ 1, 0, 1, 1, 1, 0, 1, 1, 0, 1 ],
  [ 0, 0, 0, 1, 0, 0, 0, 1, 0, 1 ],
  [ 1, 0, 1, 1, 1, 0, 0, 1, 1, 0 ],
  [ 0, 0, 0, 0, 1, 0, 0, 1, 0, 1 ],
  [ 0, 1, 1, 1, 1, 1, 1, 1, 0, 0 ],
  [ 1, 1, 1, 1, 1, 0, 0, 1, 1, 1 ],
  [ 0, 0, 1, 0, 0, 1, 1, 0, 0, 1 ],
]

class Node
  attr_accessor :pos, :dist, :prev

  def initialize pos, dist, prev
    @pos = pos
    @dist = dist
    @prev = prev
  end

  def path_to
    path = []
    path << self
    node = self.prev
    while !node.nil?
      path << node
      node = node.prev
    end
    path.map { |n| n.pos}.sort # NOTE not sure about sort
  end
end

def is_valid? coord, maze, seen
  if seen.include? coord
    return false
  end

  x, y = coord
  if x < 0 || y < 0 || x >= maze.size || y >= maze.size
    return false
  end

  if maze[x][y] != 1
    return false
  end

  true
end

def find_shortest_path(start, dest, maze)
  node = Node.new(start, 0, nil)
  seen = Set.new
  queue = []

  seen <<  node.pos
  queue << node

  adj = [
    [0, 1],
    [1, 0],
    [0, -1],
    [-1, 0],
  ]

  while !queue.empty?
    node = queue.shift

    if node.pos == dest
      p "distance: #{node.dist}"
      return "path: #{node.path_to}"
    end
    dist = node.dist

    i, j = node.pos

    neighbors = adj.map { |n| [n.first + i, n.last + j] }.select { |c| is_valid? c, maze, seen }
    neighbors.each do |pos|
      n = Node.new(pos, dist + 1, node)
      queue << n
      seen << pos
    end
  end

   p "No path found"
   return
end

p find_shortest_path([0, 0], [7, 5], maze) #12
p find_shortest_path([0, 0], [2, 2], maze) #12
p find_shortest_path([0, 0], [4, 0], maze) #12
