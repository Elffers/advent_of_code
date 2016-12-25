require 'set'
# require 'pp'
require 'pry'
require_relative 'day13'

class Maze
  attr_accessor :grid, :targets, :distances

  def initialize input
    @targets = find_targets input
    @grid = input
    @distances = find_distances
  end

  def open? coords
    x, y = coords
    grid[x][y] != '#'
  end

  def shortest_path
    goals = targets.keys.dup
    goals.delete "0"
    permutations = goals.permutation.map do |p|
      p.unshift "0"
      p << "0" # part 2
    end

    permutations.map do |permutation|
      permutation.each_cons(2).map do |start, dest|
        distances[start.to_s][dest.to_s]
      end.reduce(:+)
    end.min
  end


  def find_distances
    distances = Hash.new { |h, k| h[k] = {} }
    targets.keys.combination(2).each do |start, dest|
      dist = shortest_path_between targets[start], targets[dest]
      distances[start][dest] = dist
      distances[dest][start] = dist
    end

    distances
  end

  def shortest_path_between(start, dest)
    visited = Set.new
    queue = []

    current = Node.new start, 0
    queue << current
    visited << current.coords

    while !queue.empty?
      current = queue.shift

      return current.dist if current.coords == dest

      # valid neighbors
      x, y = current.coords
      dist = current.dist + 1

      right = Node.new [x+1, y], dist
      left  = Node.new [x-1, y], dist
      down  = Node.new [x, y+1], dist
      up    = Node.new [x, y-1], dist

      [right, left, down, up].select do |node|
        !visited.include?(node.coords) &&
          open?(node.coords) &&
          node.valid?
      end.each do |node|
        queue << node
        visited << node.coords
      end
    end
  end

  def find_targets input
    targets = {}
    input.each_with_index do |row, i|
      row.each_char.with_index do |el, j|
        if /\d/ =~ el
          targets[el] = [i, j]
        end
      end
    end

    targets
  end

end

if __FILE__ == $0
  test = StringIO.new(<<INPUT
###########
#0.1.....2#
#.#######.#
#4.......3#
###########
INPUT
                     ).readlines.map { |x| x.strip }

  # m = Maze.new test

  input = File.read('day24.in').split("\n")
  m = Maze.new input

  p m.shortest_path
end
