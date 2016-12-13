require 'set'

class Maze
  attr_accessor :input, :queue, :y, :visited, :start, :dest

  def initialize input, dest
    @input = input
    @dest = dest
    @visited = Set.new
    @start = [1, 1]
    @queue = []
  end

  def open? node
    x, y = node.x, node.y
    a = x*x + 3*x + 2*x*y + y + y*y
    a += 10
    bin = a.to_s 2
    bin.count("1").even?
  end

  # def map x, y
  #   y.times.map do |j|
  #     x.times.map do |i|
  #       open? i, j
  #     end
  #   end
  # end

  # def init_visited
  #   x, y = dest
  #   y.times.map do |j|
  #     x.times.map do |i|
  #       false
  #     end
  #   end
  # end

  def valid? node
    node.x >= 0 && node.y >= 0
  end

# We LOOP till queue is not empty
# Dequeue front cell from the queue
# Return if the destination coordinates have reached.
# For each of its four adjacent cells, if the value is 1 and they are not visited yet, we enqueue it in the queue and also mark them as visited.
  def shortest_path_to dest

    current = Node.new start, 0
    queue << current
    visited << current

    dist = 0

    while !queue.empty?
      current = queue.shift

      return current.dist if current == dest

      x, y = current.x, current.y
      dist = current.dist + 1

      right = Node.new [x+1, y], dist
      left  = Node.new [x-1, y], dist
      down  = Node.new [x, y+1], dist
      up    = Node.new [x, y-1], dist

      [right, left, down, up].each do |node|
        if !visited.include?(node) && open?(node) && valid?(node)
          queue << node
          visited << node
        end
        p queue
      end
    end

    dist
  end

  class Node
    attr_accessor :x, :y, :dist

    def initialize coords, dist
      @x = coords.first
      @y = coords.last
      @dist = dist
    end
  end

end


if __FILE__ == $0
  # dest = [31,39]
  # m = Maze.new 1364
  dest = [7, 4]
  m = Maze.new 10, dest
  p  m.shortest_path_to dest

end
