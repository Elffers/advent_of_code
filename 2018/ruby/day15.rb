require 'pp'

# input = File.read("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day15.in")
# print input
# puts
input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day15.in")
input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day15_test1.in")

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
    return if targets.empty?

    if targets.include? self.pos
      # find target in range of self.pos and attack
    else
    end

    # find open squares in range of targets
    #   - if in range, skip to attack
    #   - if none in range or open, end
    # find which in-range squares are reachable
    # pick closest reachable square

  end

  def move
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

  def find_reachable targets, grid
    adj = [
      [0, -1], # top
      [-1, 0], # left
      [1, 0],  # right
      [0, 1],  # down
    ]
    targets.each do |t|
      find_path t, grid
    end
    # A star?
  end

  def path_to target, grid
    pos = @pos
    x, y = pos
    path = []

    # base cases
    if pos = target
      return path
    end
    if grid[x][y] != "."
      return nil
    end
    if grid[x][y].nil? # outside of grid
      return nil
    end
    path = []

    adj = [
      [0, -1], # top
      [-1, 0], # left
      [1, 0],  # right
      [0, 1],  # down
    ]
    queue = []
    adj.each do |i, j|
      pt = [
    end

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
  u.find_targets elves, map
else
  u.find_targets goblins, map
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
