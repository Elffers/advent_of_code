# --- Day 1: No Time for a Taxicab ---

# Santa's sleigh uses a very high-precision clock to guide its movements, and
# the clock's oscillator is regulated by stars. Unfortunately, the stars have
# been stolen... by the Easter Bunny. To save Christmas, Santa needs you to
# retrieve all fifty stars by December 25th.

# Collect stars by solving puzzles. Two puzzles will be made available on each
# day in the advent calendar; the second puzzle is unlocked when you complete
# the first. Each puzzle grants one star. Good luck!

# You're airdropped near Easter Bunny Headquarters in a city somewhere.
# "Near", unfortunately, is as close as you can get - the instructions on the
# Easter Bunny Recruiting Document the Elves intercepted start here, and
# nobody had time to work them out further.

# The Document indicates that you should start at the given coordinates (where
# you just landed) and face North. Then, follow the provided sequence: either
# turn left (L) or right (R) 90 degrees, then walk forward the given number of
# blocks, ending at a new intersection.

# There's no time to follow such ridiculous instructions on foot, though, so
# you take a moment and work out the destination. Given that you can only walk
# on the street grid of the city, how far is the shortest path to the
# destination?

# For example:

# Following R2, L3 leaves you 2 blocks East and 3 blocks North, or 5 blocks
# away.  R2, R2, R2 leaves you 2 blocks due South of your starting position,
# which is 2 blocks away.  R5, L5, R5, R3 leaves you 12 blocks away.  How many
# blocks away is Easter Bunny HQ?
#
# --- Part Two ---

# Then, you notice the instructions continue on the back of the Recruiting
# Document. Easter Bunny HQ is actually at the first location you visit twice.

# For example, if your instructions are R8, R4, R4, R8, the first location you
# visit twice is 4 blocks away, due East.

# How many blocks away is the first location you visit twice?

#

class Traveler
  attr_accessor :facing, :x, :y, :instructions, :visited

  def initialize
    @facing = "north"
    @x = 0
    @y = 0
    @instructions = []
    @visited = Hash.new { |h, row| h[row] = Hash.new false }
  end

  def parse instructions
    instructions.each do |instr|
      /(?<dir>[R,L])(?<blocks>\d+)/ =~ instr
      instruction = Instruction.new(dir, blocks.to_i)
      @instructions << instruction
    end
  end

  def move instruction

    blocks = instruction.blocks

    if instruction.dir == "R"
      case facing
      when "north"
        self.facing = "east"
        self.x += blocks
      when "east"
        self.facing = "south"
        self.y -= blocks
      when "south"
        self.facing = "west"
        self.x -= blocks
      when "west"
        self.facing = "north"
        self.y += blocks
      end
    end
    if instruction.dir == "L"
      case facing
      when "north"
        self.facing = "west"
        self.x -= blocks
      when "west"
        self.facing = "south"
        self.y -= blocks
      when "south"
        self.facing = "east"
        self.x += blocks
      when "east"
        self.facing = "north"
        self.y += blocks
      end
    end
  end

  def mark_visited(start, stop)
    x1, y1 = start
    x2, y2 = stop

    if x1 - x2 == 0
      min = [y1, y2].min
      max = [y1, y2].max
      (min + 1 ...max).each do |block|
        if visited[x1][block] == true
          p [block, y1]
          return [x1, block]
        else
          visited[x1][block] = true
        end
      end
    end

    if y1 - y2 == 0
      min = [x1, x2].min
      max = [x1, x2].max
      (min + 1 ...max).each do |block|
        if visited[block][y1] == true
          p [block, y1]
          return [block, y1]
        else
          visited[block][y1] = true
        end
      end
    end

    # mark start and stop as visited
    visited[x1][y1] = true

    if visited[x2][y2] == true
      return [x2, y2]
    else
      visited[x2][y2] = true
    end

    false
  end

  def follow_instructions
    instructions.each do |instr|
      p [instr.to_s, facing, calculate_distance, [x, y]]
      move instr
    end
  end

  def find_visited
    instructions.each do |instr|
      start = [x, y]
      p "start: #{start}"
      p "BEFORE visited: #{visited}"
      p "--------------------"

      move instr

      stop = [x, y]
      p "stop: #{stop}"
      p "AFTER visited: #{visited}"
      p "--------------------"

      visits = mark_visited(start, stop)

      unless visits == false
        a, b = visits
        p [a, b]
        self.x = a
        self.y = b
        return calculate_distance
      end
    end
  end

  def calculate_distance
    x.abs + y.abs
  end

  class Instruction
    attr_accessor :dir, :blocks

    def initialize(dir, blocks)
      @dir = dir
      @blocks = blocks
    end

    def to_s
      dir + blocks.to_s
    end
  end
end

if $0 == __FILE__
  input = File.read('day01.in').strip.split(",")

  t = Traveler.new
  t.parse input
  t.follow_instructions
  p t.calculate_distance

  r = Traveler.new
  r.parse input
  p r.find_visited
end

#232 not right
#142 not right
