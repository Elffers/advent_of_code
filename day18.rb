# --- Day 18: Like a GIF For Your Yard ---

# After the million lights incident, the fire code has gotten stricter: now,
# at most ten thousand lights are allowed. You arrange them in a 100x100 grid.

# Never one to let you down, Santa again mails you instructions on the ideal
# lighting configuration. With so few lights, he says, you'll have to resort
# to animation.

# Start by setting your lights to the included initial configuration (your
# puzzle input). A # means "on", and a . means "off".

# Then, animate your grid in steps, where each step decides the next
# configuration based on the current one. Each light's next state (either on
# or off) depends on its current state and the current states of the eight
# lights adjacent to it (including diagonals). Lights on the edge of the grid
# might have fewer than eight neighbors; the missing ones always count as
# "off".

# For example, in a simplified 6x6 grid, the light marked A has the neighbors
# numbered 1 through 8, and the light marked B, which is on an edge, only has
# the neighbors marked 1 through 5:

# 1B5...  234...  ......  ..123.  ..8A4.  ..765.  The state a light should
# have next is based on its current state (on or off) plus the number of
# neighbors that are on:

# - A light which is on stays on when 2 or 3 neighbors are on, and turns off
# otherwise.
# - A light which is off turns on if exactly 3 neighbors are on, and
# stays off otherwise.
# - All of the lights update simultaneously; they all consider the same current state before moving to the next.
#
# In your grid of 100x100 lights, given your initial configuration, how many
# lights are on after 100 steps?

class Display
  attr_accessor :grid, :max

  def initialize input
    # Array of strings
    @grid = input.map do |line|
      line.strip.split("").map { |light| light == "#" }
    end

    @max = input.size - 1
  end

  def animate steps
    steps.times do
      change
    end
  end

  def light_corners(grid)
    grid[0][0] = true
    grid[0][max] = true
    grid[max][0] =  true
    grid[max][max] = true
  end

  def count_lit
    grid.flatten.count(true)
  end

  def change
    new_grid = []
    light_corners(grid)
    grid.each.with_index do |row, i|
      new_row = []
      # for each row, find number of adjacent lights that are on
      row.each_with_index do |light, j|
        lighted = lit_neighbors i, j
        new_light =
          if light
            lighted.between? 2, 3
          else
            lighted == 3
          end
        new_row << new_light
      end
      new_grid << new_row
    end
    light_corners(new_grid)
    self.grid = new_grid
  end

  def lit_neighbors i, j
    neighbors = find_neighbors i, j
    neighbors.count(true)
  end


  def find_neighbors(i,j)
    neighbors = []
    # top row
    northwest = grid[i-1][j-1]
    north = grid[i-1][j]
    northeast = grid[i-1][j+1]

    # same row
    west = grid[i][j-1]
    east = grid[i][j+1]

    # bottom row
    if i != max
      southwest = grid[i+1][j-1]
      south = grid[i+1][j]
      southeast = grid[i+1][j+1]
    end

    if i > 0 && i < max &&  # Not in first or last row
      if j > 0 && j < max # Not in first or last column
        neighbors << north
        neighbors << northwest
        neighbors << northeast
        neighbors << west
        neighbors << east
        neighbors << south
        neighbors << southwest
        neighbors << southeast
      elsif j == max # On the right edge but not right corners
        neighbors << north
        neighbors << northwest
        neighbors << west
        neighbors << south
        neighbors << southwest
      elsif j == 0 # On the left edge but not left corners
        neighbors << north
        neighbors << northeast
        neighbors << east
        neighbors << south
        neighbors << southeast
      end

    elsif i == 0 # in top row
      if j == 0 # top left corner
        neighbors << east
        neighbors << southeast
        neighbors << south
      elsif j == max # top right corner
        neighbors << west
        neighbors << southwest
        neighbors << south
      else
        neighbors << west
        neighbors << east
        neighbors << south
        neighbors << southwest
        neighbors << southeast
      end
    elsif i == max # in bottom row
      if j == 0 # bottom left corner
        neighbors << east
        neighbors << northeast
        neighbors << north
      elsif j == max # bottom right corner
        neighbors << west
        neighbors << northwest
        neighbors << north
      else
        neighbors << west
        neighbors << east
        neighbors << north
        neighbors << northwest
        neighbors << northeast
      end
    end

    neighbors
  end
end

if __FILE__ == $0
  input = File.readlines('day18_input.txt')
  d = Display.new input
  d.animate 100
  d.grid
  p d.count_lit
end
