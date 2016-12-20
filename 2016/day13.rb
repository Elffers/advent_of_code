require 'set'

class Maze
  attr_accessor :input, :visited, :queue

  def initialize input
    @input = input
    @visited = Set.new
    @queue = []
  end

  def open? coords
    x, y = coords
    a = x*x + 3*x + 2*x*y + y + y*y
    a += input
    bin = a.to_s 2
    bin.count("1").even?
  end

  def valid_neighbors current
    x, y = current.coords
    dist = current.dist + 1

    right = Node.new [x+1, y], dist
    left  = Node.new [x-1, y], dist
    down  = Node.new [x, y+1], dist
    up    = Node.new [x, y-1], dist

    [right, left, down, up].select do |node|
      !visited.include?(node.coords) && open?(node.coords) && node.valid?
    end
  end

  def shortest_path dest
    current = Node.new [1, 1], 0
    queue << current
    visited << current.coords
    count = 0 # part 2

    while !queue.empty?
      current = queue.shift
      x, y = current.coords

      p current.dist if [x, y] == dest # part 1

      count += 1 if current.dist <= 50

      nodes = valid_neighbors current
      nodes.each do |node|
        queue << node
        visited << node.coords
      end
    end

    count
  end
end

class Node
  attr_accessor :coords, :dist

  def initialize coords, dist
    @coords = coords
    @dist = dist
  end

  def valid?
    x, y = coords
    x >= 0 && y >= 0
  end
end

if __FILE__ == $0
  dest = [31, 39]
  m = Maze.new 1364
  p  m.shortest_path dest
end
