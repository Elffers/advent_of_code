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

class Mapper
  attr_accessor :visited, :row, :column

  def initialize
    @visited = Hash.new do |h, row|
      h[row] = Hash.new false # column => visited
    end
    @row = 0
    @column = 0
  end

  def count_houses(input)
    input.each_char.reduce 1 do |count, char|
      @visited[@row][@column] = true

      case char
      when ">"
        @column += 1
      when "^"
        @row -= 1
      when "<"
        @column -= 1
      when "v"
        @row += 1
      end

      if @visited[@row][@column] == false
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
end
