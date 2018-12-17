require 'pp'
require 'set'
require 'pry'

# input = File.read("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day15.in")
# input = File.readlines("./inputs/day15.in")
# input = File.readlines("./inputs/day15_test1.in")
input = File.readlines("./inputs/day15_test2.in")

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
      path.unshift node
      node = node.prev
    end
    path.map { |n| n.pos} #.sort # NOTE not sure about sort
  end
end

class Grid
  attr_accessor :elves, :goblins, :units, :state, :rows, :cols

  def initialize rows, cols
    @rows = rows
    @cols = cols
    @elves = []
    @goblins = []
    @units = []
    @state = Hash.new { |h, k| h[k] = Hash.new }
  end

  def to_s
    @state.each do |k,row|
      p row.values.join
    end
  end
end

class Unit
  attr_accessor :x, :y, :pts, :pwr, :grid

  def initialize x, y, grid
    @x = x
    @y = y
    @pts =  200
    @pwr = 3
    @grid = grid
  end

  def pos
    [@x, @y]
  end

  def alive?
    @alive
  end

  def take_turn
    # find all targets
    targets = find_targets self.enemies
    p "targets: #{targets}"

    # no open spots
    return if targets.empty?

    if targets.include? pos
      p "IN RANGE"
      attack
    else
      path = choose_path targets
      p "path: #{path}"
      step = path[1] #path[0] should be self.pos
      move_to step
      p "pos after move: #{pos}"
      attack
    end

  end

  def move_to step
    # p "old position: #{pos}"
    char = @grid.state[@x][@y]
    @grid.state[@x][@y] = "."
    i, j = step
    self.x = i
    self.y = j
    # p "new position: #{pos}"
    @grid.state[i][j] = char
  end

  def attack
    # p "current position: #{pos}"
    enemy_type = self.sym == "E" ? "G" : "E"
    adj = [
      [0, -1], # top
      [-1, 0], # left
      [1, 0],  # right
      [0, 1],  # down
    ]
    enemies = []
    adj.each do |x, y|
      i, j = [@x + x, @y + y]
      # p [pos, i, j]
      if grid.state[i][j] == enemy_type
        enemy = @enemies.find { |e| e.x == i && e.y == j }
        # TODO locate in enemies array
        enemies << enemy
      end
    end

    return if enemies.empty?

    p "BEFORE ENEMY POINTS: #{@enemies.map { |x| x.pts }}"
    # p "attack candidates: #{enemies.size}"
    opp = choose_opponent enemies
    # p self.sym
    p "attack candidates: #{opp.pos}"

    p "pts before: #{opp.pts}"
    opp.pts -= @pwr

    p "pts after : #{opp.pts}"
    # p "total enemies before: #{@enemies.size}"
    # move out of this method?
    if opp.pts < 0
      ox, oy = opp.pos
      @enemies.delete opp
      grid.state[ox][oy] = "."
    end
    # p "total enemies after: #{@enemies.size}"
    # p "total enemies after: #{@grid.goblins.size}"
  end

  def choose_opponent enemies
    # choose opponent in order of:
    #   - adjacent
    #   - fewest hit points
    #   - in read order
    min_pts = 201
    hit_pts = Hash.new { |h, k| h[k] = [] }
    enemies.each do |x|
      if x.pts < min_pts
        min_pts = x.pts
      end
      hit_pts[x.pts] << x
    end
    # p "HIT PITS: #{hit_pts.size}, min_pts: #{min_pts}"
    candidates = hit_pts[min_pts]
    # p "choosing from: #{candidates.size}"
    opps = candidates.sort_by { |e| e.pos }
    p "CHOOSING OPPS FROM: #{opps.map { |x| [x.pos, x.pts] }}"
    opps.first
  end

  def is_a? type
    self.class == type
  end

  def dist pt
    x, y = pt
    (@x - x).abs + (@y - y).abs
  end

  # Finds open squares adjacent to enemies
  def find_targets enemies
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
        if @grid.state[i][j] == "." || pos == [i, j]
          targets << [i, j]
        end
      end
    end
    targets.sort_by!(&:itself) # probably don't need to sort quite yet
  end

  def choose_path targets
    min_dist = @grid.rows * @grid.cols
    distances = Hash.new { |h, k| h[k] = [] }

    targets.each do |target|
      node = shortest_path_to target
      if node
        distances[node.dist] << node.path_to
        if node.dist < min_dist
          min_dist = node.dist
        end
      end
    end
    p "Distances: #{distances[min_dist].sort.first}"

    distances[min_dist].sort.first
  end

  # Use BFS to find shortest path to target, if any
  # NOTE: do we actually account for the path being the shortest possible?
  # NOTE: path to node includes starting node -- will need to account for this
  # when choosing step to take
  def shortest_path_to target
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

      neighbors = adj.map { |n| [n.first + i, n.last + j] }.select { |c| is_valid? c, seen }
      neighbors.each do |pos|
        n = Node.new(pos, dist + 1, node)
        queue << n
        seen << pos
      end
    end

    # p "No path found to #{target}"
    return
  end

  def is_valid? coord, seen
    if seen.include? coord
      return false
    end

    x, y = coord
    if x < 0 || y < 0 || x >= @grid.cols || y >= @grid.rows
      return false
    end

    if @grid.state[x][y] != "."
      return false
    end

    true
  end
end

class Elf < Unit
  attr_accessor :enemies, :sym

  def initialize i, j, grid
    super
    @enemies = self.grid.goblins
    @sym = "E"

  end
end

class Goblin < Unit
  attr_accessor :enemies, :sym

  def initialize i, j, grid
    super
    @enemies = self.grid.elves
    @sym = "G"
  end
end

##############################################
grid = Grid.new(input.size, input.first.size)
input.each_with_index do |row, i|
  row.strip.chars.each_with_index do |char, j|
    if char == "G"
      g = Goblin.new(i, j, grid)
      grid.goblins << g
      grid.units << g
    elsif char == "E"
      e = Elf.new(i, j, grid)
      grid.elves << e
      grid.units << e
    end
    grid.state[i][j] = char
  end
end

##############   TEST   #####################

# u = grid.units.first
# grid.to_s
# 3.times do
#   if u.is_a? Goblin
#     u.take_turn grid.elves
#   else
#     u.take_turn grid.goblins
#   end
#   puts
#   grid.to_s
# end

# grid.to_s

rounds = 0
# while goblins.any? { |g| g.alive? } || elves .any? { |e| g.alive? }
loop do
  rounds += 1

  sorted = grid.units.sort_by { |u| u.pos }
  sorted.each do |unit|
    p "current unit: #{unit.pos}"
    unit.take_turn
    if unit.enemies.empty?
      return rounds
    end
  end
  grid.to_s
  p "FINAL ELF HIT POINTS: #{grid.elves.map { |x| x.pts }}"
  p "FINAL GOBLIN HIT POINTS: #{grid.goblins.map { |x| x.pts }}"
  p "ROUND: #{rounds}"
  puts
end
