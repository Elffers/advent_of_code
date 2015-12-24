# --- Day 3: Perfectly Spherical Houses in a Vacuum ---

# Santa is delivering presents to an infinite two-dimensional grid of houses.

# He begins by delivering a present to the house at his starting location, and
# then an elf at the North Pole calls him via radio and tells him where to
# move next. Moves are always exactly one house to the north (^), south (v),
# east (>), or west (<). After each move, he delivers another present to the
# house at his new location.

# However, the elf back at the north pole has had a little too much eggnog,
# and so his directions are a little off, and Santa ends up visiting some
# houses more than once. How many houses receive at least one present?

# For example:

# > delivers presents to 2 houses: one at the starting location, and one to
# the east.  ^>v< delivers presents to 4 houses in a square, including twice
# to the house at his starting/ending location.  ^v^v^v^v^v delivers a bunch
# of presents to some very lucky children at only 2 houses.

# --- Part Two ---

# The next year, to speed up the process, Santa creates a robot version of himself, Robo-Santa, to deliver presents with him.

# Santa and Robo-Santa start at the same location (delivering two presents to the same starting house), then take turns moving based on instructions from the elf, who is eggnoggedly reading from the same script as the previous year.

# This year, how many houses receive at least one present?

# For example:

# ^v delivers presents to 3 houses, because Santa goes north, and then Robo-Santa goes south.
# ^>v< now delivers presents to 3 houses, and Santa and Robo-Santa end up back where they started.
# ^v^v^v^v^v now delivers presents to 11 houses, with Santa going one direction and Robo-Santa going the other.

class Santa
  attr_accessor :row, :column

  def initialize
    @row = 0
    @column = 0
  end

  def coordinates
    [@row, @column]
  end

  def move_north
    @row -= 1
  end

  def move_south
    @row += 1
  end

  def move_west
    @column -= 1
  end

  def move_east
    @column += 1
  end

  def move(char)
    case char
    when ">"
      move_east
    when "^"
      move_north
    when "<"
      move_west
    when "v"
      move_south
    end
  end
end

class Mapper
  attr_accessor :visited, :santa

  def initialize
    @visited = Hash.new do |h, row|
      h[row] = Hash.new false # column => visited
    end
    @santa = Santa.new
  end

  def count_houses(input)
    input.each_char.reduce 1 do |count, char|
      @visited[santa.row][santa.column] = true
      santa.move(char)

      if @visited[santa.row][santa.column] == false
        count + 1
      else
        count
      end
    end
  end
end

class RoboMapper < Mapper
  attr_accessor :robosanta

  def initialize
    @robosanta = Santa.new
    super
  end

  def count_houses(input)
    input.each_char.with_index.reduce 1 do |count, (char, i)|
      santa = i.even? ? @santa : @robosanta

      @visited[santa.row][santa.column] = true
      santa.move(char)

      if @visited[santa.row][santa.column] == false
        count + 1
      else
        count
      end
    end
  end
end

if $0 == __FILE__
  input = File.read('day3_input.txt')
  mapper = Mapper.new
  p mapper.count_houses(input)
  rmapper = RoboMapper.new
  p rmapper.count_houses(input)
end
