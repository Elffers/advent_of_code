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

class Traveler
  attr_accessor :facing, :x, :y, :instructions, :visited

  TURN_LEFT = {
    'north' => 'west',
    'south' => 'east',
    'east' => 'north',
    'west' => 'south',
  }

  TURN_RIGHT = {
    'north' => 'east',
    'south' => 'west',
    'east' => 'south',
    'west' => 'north',
  }

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

  def follow instruction
    blocks = instruction.blocks

    if instruction.dir == "R"
      self.facing = TURN_RIGHT[facing]
      move blocks
    elsif instruction.dir == "L"
      self.facing = TURN_LEFT[facing]
      move blocks
    end
  end

  def move blocks
    case facing
    when 'east'
      self.x += blocks
    when 'west'
      self.x -= blocks
    when 'north'
      self.y += blocks
    when 'south'
      self.y -= blocks
    end
  end

  def follow_instructions
    instructions.each { |instr| follow instr }
  end

  def calculate_distance
    x.abs + y.abs
  end

  ##################
  # Part 2 methods #
  ##################

  def block_range start, stop
    min = [start, stop].min
    max = [start, stop].max

    (min + 1...max)
  end

  # Marks each block between start and stop coordinates as visited. Returns
  # coordinates of current block if it has been visited before, otherwise
  # returns false.

  def mark_visited(start, stop)
    x1, y1 = start
    x2, y2 = stop

    if x1 - x2 == 0
      blocks = block_range y1, y2
      row = x1

      blocks.each do |block|
        if visited[row][block] == true
          return [row, block]
        end

        visited[row][block] = true
      end
    end

    if y1 - y2 == 0
      blocks = block_range x1, x2
      col = y1

      blocks.each do |block|
        if visited[block][col] == true
          return [block, col]
        end

        visited[block][col] = true
      end
    end

    # Mark start and stop coords visited after to avoid counting endpoints
    # twice during traversal.

    # NOTE: Marking start as true is only relevant for the first direction;
    # everywhere else it will already be true since it will have been the
    # ending point of the last instruction.
    visited[x1][y1] = true

    if visited[x2][y2] == true
      return [x2, y2]
    else
      visited[x2][y2] = true
    end

    false
  end

  def find_visited
    instructions.each do |instr|
      start = [x, y]
      follow instr
      stop = [x, y]

      visited_coords = mark_visited(start, stop)

      unless visited_coords == false
        a, b = visited_coords
        self.x = a
        self.y = b

        return [x, y]
      end
    end
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
  p "distance: #{t.calculate_distance}"

  r = Traveler.new
  r.parse input
  r.find_visited
  p "distance to first visited: #{r.calculate_distance}"
end
