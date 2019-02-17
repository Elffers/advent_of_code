require 'pp'
require 'set'

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
    path.map { |n| n.pos}
  end
end

class Grid
  attr_accessor :units, :state, :rows, :cols

  def initialize rows, cols
    @rows = rows
    @cols = cols
    @state = Hash.new { |h, k| h[k] = Hash.new }
  end

  def to_s
    @state.each do |k,row|
      p row.values.join
    end
  end

  def populate units
     @units = units
  end

  def goblins
    @units.select { |u| u.sym == "G" }
  end

  def elves
    @units.select { |u| u.sym == "E" }
  end
end

class Unit
  attr_accessor :x, :y, :pts, :pwr, :grid, :sym

  def initialize x, y, grid, sym, pwr
    @x = x
    @y = y
    @pts =  200
    @pwr = pwr
    @grid = grid
    @sym = sym
  end

  def pos
    [@x, @y]
  end

  def take_turn
    targets = find_targets

    return if targets.empty?

    if targets.include? pos
      attack
    else
      path = choose_path targets
      return if path.nil?
      step = path[1] # path[0] should be self.pos
      move_to step
      attack
    end
  end

  def move_to step
    char = @grid.state[@x][@y]
    @grid.state[@x][@y] = "."
    i, j = step
    self.x = i
    self.y = j
    @grid.state[i][j] = char
  end

  def attack
    enemy_type = self.sym == "E" ? "G" : "E"
    adj = [
      [0, -1], # top
      [-1, 0], # left
      [1, 0],  # right
      [0, 1],  # down
    ]
    opps = []
    adj.each do |x, y|
      i, j = [@x + x, @y + y]
      if grid.state[i][j] == enemy_type
        opp = get_enemies.find { |e| e.x == i && e.y == j }
        opps << opp
      end
    end

    return if opps.empty?

    opp = choose_opponent opps
    # p "opp power before: #{opp.pts}"
    opp.pts -= @pwr
    # p "opp power after: #{opp.pts}"

    if opp.pts < 0
      ox, oy = opp.pos
      grid.state[ox][oy] = "."
      @grid.units.delete opp
    end
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
    candidates = hit_pts[min_pts]
    opps = candidates.sort_by { |e| e.pos }
    opps.first
  end

  def get_enemies
    if @sym == "G"
      @grid.elves
    else
      @grid.goblins
    end
  end

  # Finds open squares adjacent to enemies
  def find_targets
    adj = [
      [0, -1], # top
      [-1, 0], # left
      [1, 0],  # right
      [0, 1],  # down
    ]
    targets = []
    get_enemies.each do |t|
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
    distances[min_dist].sort.first
  end

  # Use BFS to find shortest path to target, if any
  # NOTE: do we actually account for the path being the shortest possible?
  # NOTE: path to node includes starting node -- will need to account for this
  # when choosing step to take
  def shortest_path_to target
    node = Node.new(pos, 0, nil)
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

      neighbors = adj.map { |x, y| [x+i, y+j] }.select { |c| is_valid? c, seen }
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
    return false if seen.include? coord

    x, y = coord
    if x < 0 || y < 0 || x >= @grid.cols || y >= @grid.rows
      return false
    end

    return false if @grid.state[x][y] != "."

    true
  end
end

def process_input input, pwr
  grid = Grid.new(input.size, input.first.size)
  units = []

  input.each_with_index do |row, i|
    row.strip.chars.each_with_index do |char, j|
      if char == "E"
        e = Unit.new(i, j, grid, char, pwr)
        units << e
      end
      if char == "G"
        e = Unit.new(i, j, grid, char, 3)
        units << e
      end
      grid.state[i][j] = char
    end
  end

  grid.populate units

  grid
end

def run grid
  rounds = 0
  elves = grid.elves.size
  until grid.goblins.empty? # || grid.elves.empty?
    sorted = grid.units.sort_by { |u| u.pos }
    sorted.each_with_index do |unit, i|
      unit.take_turn

      if grid.elves.size < elves
        return "OH NO"
      end

      if unit.get_enemies.empty?
        p "FINAL ELF POINTS: #{grid.elves.map { |x| x.pts }}"
        p "FINISHED ROUND: #{rounds}"
        grid.to_s
        return "Part 1: #{rounds * grid.units.map { |x| x.pts }.reduce(:+)}"
      end
    end

    rounds += 1

        p "FINAL ELF POINTS: #{grid.elves.map { |x| x.pts }}"
        p "FINAL GOBLIN POINTS: #{grid.goblins.map { |x| x.pts }}"

    p "FINISHED ROUND: #{rounds}"
    puts
  end
end

tests = File.read("./inputs/day15_test3.in").split("\n\n").map do |str|
  str.split("\n")
end

test_grids = tests.map { |t| process_input t, 3 }
# test_grids.each { |test| run test } # first two tests off by one round?

input = File.readlines("./inputs/day15.in")
# input = File.readlines("./inputs/day15_test2.in")

# grid = process_input input, 100

# binary search for power
min = 4
min = 10
# max = 100

# input = tests[3]
# p input
grid = process_input input, min
res = run grid

while res == "OH NO"
  grid = process_input input, min
  res = run grid
  p "MIN: #{min}"
  min+=1
  puts
end
p res
