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
    node = self
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

  def take_turn enemies, grid
    # find all targets
    targets = find_targets enemies, grid
    # p "targets: #{targets}"

    # all enemies are dead
    return if targets.empty?

    if !targets.include? self.pos
      path = choose_path targets, grid
      step = path[1] #path[0] should be self.pos
      move_to step, grid
    end

    # attack
  end

  def move_to step, grid
    char = grid[@x][@y]
    grid[@x][@y] = "."
    i, j = step
    self.x = i
    self.y = j
    grid[i][j] = char
  end

  def attack
    enemy_type = self.is_a? Goblin ? "E" : "G"
    # choose opponent in order of:
    #   - adjacent
    #   - fewest hit points
    #   - in read order
    adj = [
      [0, -1], # top
      [-1, 0], # left
      [1, 0],  # right
      [0, 1],  # down
    ]
    enemies = []
    adj.each do |x, y|
      i, j = [@x + x, @y + y]
      if grid[i][j] == enemy_type
        # TODO locate in enemies array
        enemies << [i, j]
      end
    end

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
    targets.sort_by!(&:itself) # probably don't need to sort quite yet
  end

  def choose_path targets, grid
    min_dist = grid.size * grid.size
    distances = Hash.new { |h, k| h[k] = [] }

    targets.each do |target|
      node = shortest_path_to target, grid
      if node
        distances[node.dist] << node.path_to
        if node.dist < min_dist
          min_dist = node.dist
        end
      end
    end
    # p distances

    distances[min_dist].sort.first
  end

  # Use BFS to find shortest path to target, if any
  # NOTE: do we actually account for the path being the shortest possible?
  # NOTE: path to node includes starting node -- will need to account for this
  # when choosing step to take
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

      return node if node.pos == target

      dist = node.dist
      i, j = node.pos

      neighbors = adj.map { |n| [n.first + i, n.last + j] }.select { |c| is_valid? c, grid, seen }
      neighbors.each do |pos|
        n = Node.new(pos, dist + 1, node)
        queue << n
        seen << pos
      end
    end

    # p "No path found to #{target}"
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

def print_grid grid
  grid.each do |k,row|
    p row.values.join
  end
end

# TODO: change to hashmap with key = position
elves = []
goblins = []
units = []

grid = Hash.new { |h, k| h[k] = Hash.new }

input.each_with_index do |row, i|
  row.strip.chars.each_with_index do |char, j|
    if char == "G"
      g = Goblin.new(i, j)
      goblins << g
      units << g
    elsif char == "E"
      e = Elf.new(i, j)
      elves << e
      units << e
    end
    grid[i][j] = char
  end
end

u = units.first
print_grid grid
if u.is_a? Goblin
  u.take_turn elves, grid
else
  u.take_turn goblins, grid
end

print_grid grid

# while goblins.any? { |g| g.alive? } || elves .any? { |e| g.alive? }
# rounds = 0
# units.sort_by { |u| u.pos }.each do |u|
#   if u.alive?
#     u.take_turn
#   end

#   rounds += 1
# end
# end
