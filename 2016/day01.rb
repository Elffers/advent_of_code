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

require 'set'

class Traveler
  attr_accessor :facing, :x, :y, :visited

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
    @visited = Set.new
  end

  def parse instr
    /(?<dir>[R,L])(?<blocks>\d+)/ =~ instr
    [dir, blocks.to_i]
  end

  def turn dir
    if dir == "R"
      self.facing = TURN_RIGHT[facing]
    elsif dir == "L"
      self.facing = TURN_LEFT[facing]
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

  def read_instructions input
    input.each do |instr|
      dir, blocks = parse instr
      turn dir
      yield blocks
    end
  end

  def follow_instructions input
    read_instructions input do |blocks|
      move blocks
    end
  end

  def calculate_distance
    x.abs + y.abs
  end

  ##################
  # Part 2 methods #
  ##################

  def find_visited input
    read_instructions input do |blocks|
      visited << [x, y]

      blocks.times do
        move 1

        if visited.include? [x, y]
          return
        else
          visited << [x, y]
        end

      end
    end
  end
end

if $0 == __FILE__
  input = File.read('day01.in').strip.split(",")

  t = Traveler.new
  t.follow_instructions input
  p "distance: #{t.calculate_distance}"

  r = Traveler.new
  r.find_visited input
  p "distance to first visited: #{r.calculate_distance}"
end
