require 'pp'
require 'set'
class Maze
  attr_accessor :input, :start, :dest, :visited, :queue

  def initialize(input, dest)
    @input = input
    @start = [1, 1]
    @dest = dest
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

  def valid? node
    x, y = node.coords
    x >= 0 && y >= 0
  end

  def print
    x, y = dest
    y.times.map do |j|
      x.times.map do |i|
        open?([i, j]) ? 'o' : '#'
      end.join
    end
  end

  def valid_neighbors current
    x, y = current.coords
    dist = current.dist + 1

    right = Node.new [x+1, y], dist
    left  = Node.new [x-1, y], dist
    down  = Node.new [x, y+1], dist
    up    = Node.new [x, y-1], dist

    [right, left, down, up].select do |node|
      !visited.include?(node.coords) && open?(node.coords) && valid?(node)
    end
  end

  def shortest_path
    current = Node.new start, 0
    queue << current
    visited << current.coords
    candidates = []

    while !queue.empty?
      current = queue.shift
      x, y = current.coords

      # return current.dist if [x, y] == dest
      candidates << current if current.dist <= 50

      nodes = valid_neighbors current

      nodes.each do |node|
        queue << node
        visited << node.coords
      end
    end
    candidates.size
  end
end

class Node
  attr_accessor :coords, :dist

  def initialize coords, dist
    @coords = coords
    @dist = dist
  end
end


if __FILE__ == $0
  dest = [7, 4]
  m = Maze.new 10, dest
  # p m.shortest_path

  dest = [31, 39]
  m = Maze.new 1364, dest
  p  m.shortest_path
end
