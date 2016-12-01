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
  attr_accessor :facing, :x, :y, :instructions, :last_four

  def initialize
    @facing = "north"
    @x = 0
    @y = 0
    @instructions = []
    @last_four = []
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

  def update_last_four(instr)
    # could add current coords here?
    if last_four.size == 4
      last_four.shift
    end

    last_four << instr
  end

  def check_last_four #last_four
    return if last_four.size < 4
    a, b, c, d = last_four

    # check to see if the last three turns were in the same direction

    return if [b.dir, c.dir, d.dir].uniq.length > 1
    return if a.blocks < c.blocks
    return if d.blocks < b.blocks

    new_instr = instructions.dup
    new_instr.pop
    new_last = new_instr[1]
    new_instr << new_last

    # return distance from last intersection
    d.blocks - b.blocks
  end

  def follow_instructions
    instructions.each do |instr|
      move instr
    end
  end

  def find_visited
    instructions.each do |instr|
      move instr
      p [instr.to_s, facing, calculate_distance, [x, y]]
      update_last_four instr

      if blocks = check_last_four
        backtrack blocks
        p [x, y]
        return calculate_distance
      end
    end
  end

  def backtrack blocks
    # construct instruction
    # blocks is the diff returned from check last four
    # direction is reverse of current facing
    case facing
    when "north"
      self.y -= blocks
    when "south"
      self.y += blocks
    when "east"
      self.x -= blocks
    when "west"
      self.x += blocks
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
  input = File.read('day01_input.txt').strip.split(",")

  t = Traveler.new
  t.parse input
  t.follow_instructions
  p t.calculate_distance

  r = Traveler.new
  r.parse input
  p r.find_visited
end
