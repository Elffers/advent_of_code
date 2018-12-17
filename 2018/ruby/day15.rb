require 'pp'
require 'set'

# input = File.read("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day15.in")
# print input
# puts
input = File.readlines("./inputs/day15.in")
input = File.readlines("./inputs/day15_test1.in")

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

class Unit
  attr_accessor :x, :y, :pts, :pwr, :alive

  def initialize x, y
    @x = x
    @y = y
    @pts = 200
    @pwr = 3
    @alive = true
  end

  def pos
    [@x, @y]
  end

  def alive?
    @alive
  end

  def take_turn grid, enemies
    # find all targets
    targets = find_targets enemies
    # all enemies are dead
    return if targets.empty?

    # already in range
    if targets.include? self.pos
      # find target in range of self.pos and attack
    else

      # find open squares in range of targets
      #   - if in range, skip to attack
      #   - if none in range or open, end
      # find which in-range squares are reachable
      # pick closest reachable square
    end

  end

  def attack opp
    opp.pts -= @pwr

    # move out of this method?
    if opp.pts < 0
      opp.alive = false
    end
  end

  def is_a? type
    self.class == type
  end

  def dist pt
    x, y = pt
    (@x - x).abs + (@y - y).abs
  end

  # Finds open squares adjacent to enemies
  def find_targets enemies, grid
    adj = [
      [0, -1], # top
      [-1, 0], # left
      [1, 0],  # right
      [0, 1],  # down
    ]
    targets = []
    enemies.each do |t|
      adj.each do |x, y|
        i, j = [t.x + x, t.y + y]
        if grid[i][j] == "."
          targets << [i, j]
        end
      end
    end
    targets.sort_by!(&:itself)
  end

  # Use BFS to find shortest path to each target
  def find_reachable targets, grid
    targets.map do |target|
      shortest_path_to target, grid
    end.compact
  end

  def shortest_path_to target, grid
    node = Node.new(self.pos, 0, nil)
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

      if node.pos == target
        # p "distance: #{node.dist}"
        # p "path: #{node.path_to}"
        return node.path_to
      end

      dist = node.dist
      i, j = node.pos

      neighbors = adj.map { |n| [n.first + i, n.last + j] }.select { |c| is_valid? c, grid, seen }
      neighbors.each do |pos|
        n = Node.new(pos, dist + 1, node)
        queue << n
        seen << pos
      end
    end

    p "No path found to #{target}"
    return
  end

  def is_valid? coord, grid, seen
    if seen.include? coord
      return false
    end

    x, y = coord
    if x < 0 || y < 0 || x >= grid.size || y >= grid.size
      return false
    end

    if grid[x][y] != "."
      return false
    end

    true
  end
end

class Elf < Unit; end
class Goblin < Unit; end

elves = []
goblins = []
units = []

map = Hash.new { |h, k| h[k] = Hash.new }

input.each_with_index do |row, i|
  row.strip.chars.each_with_index do |char, j|
    if char == "G"
      g = Goblin.new(i, j)
      goblins << g
      units << g
      # map[i][j] = "."
    elsif char == "E"
      e = Elf.new(i, j)
      elves << e
      units << e
      # map[i][j] = "."
    end
    map[i][j] = char
  end
end

# pp goblins, elves
# p units
u = units.first
# p u
if u.is_a? Goblin
  t = u.find_targets elves, map
  r = u.find_reachable t, map
  p r
else
  t =  u.find_targets goblins, map
  r = u.find_reachable t, map
  p r
end

def print_map map
  map.each do |k,row|
    p row.values.join
  end
end

# print_map map

# while goblins.any? { |g| g.alive? } || elves .any? { |e| g.alive? }
# rounds = 0
# units.sort_by { |u| u.pos }.each do |u|
#   if u.alive?
#     u.take_turn
#   end

#   rounds += 1
# end
# end
