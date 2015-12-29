# --- Day 6: Probably a Fire Hazard ---

# Because your neighbors keep defeating you in the holiday house decorating
# contest year after year, you've decided to deploy one million lights in a
# 1000x1000 grid.

# Furthermore, because you've been especially nice this year, Santa has mailed
# you instructions on how to display the ideal lighting configuration.

# Display in your grid are numbered from 0 to 999 in each direction; the lights
# at each corner are at 0,0, 0,999, 999,999, and 999,0. The instructions
# include whether to turn on, turn off, or toggle various inclusive ranges
# given as coordinate pairs. Each coordinate pair represents opposite corners
# of a rectangle, inclusive; a coordinate pair like 0,0 through 2,2 therefore
# refers to 9 lights in a 3x3 square. The lights all start turned off.

# To defeat your neighbors this year, all you have to do is set up your lights
# by doing the instructions Santa sent you in order.

# For example:

# turn on 0,0 through 999,999 would turn on (or leave on) every light.  toggle
# 0,0 through 999,0 would toggle the first line of 1000 lights, turning off
# the ones that were on, and turning on the ones that were off.  turn off
# 499,499 through 500,500 would turn off (or leave off) the middle four
# lights.  After following the instructions, how many lights are lit?
#

class Display
  attr_accessor :grid

  def initialize
    @grid = Array.new(1000) { Array.new 1000, " "}
  end

  def count_lights
    @grid.reduce(0) do |count, row|
      row.count("*") + count
    end
  end

  def flip(coord1, coord2, action)
    range(coord1, coord2) do |light|
      case action
      when :on
        "*"
      when :off
        " "
      when :toggle
        light == " " ? "*" : " "
      end
    end
  end

  def parse_instruction instr
    /(?<action>turn on|turn off|toggle) (?<coord1>\d+,\d+) through (?<coord2>\d+,\d+)/ =~ instr

    raise "Unknown instruction #{instr}" unless action

    x1, y1 = coord1.split(",").map { |c| c.to_i }
    x2, y2 = coord2.split(",").map { |c| c.to_i }

    action =
      case action
      when "turn on"
        :on
      when "turn off"
        :off
      when "toggle"
        :toggle
      end

    [[x1, y1], [x2, y2], action]
  end

  private

  def range(coord1, coord2)
    x1, y1 = coord1
    x2, y2 = coord2
    (x1..x2).each do |row|
      (y1..y2).each do |col|
        grid[row][col] = yield(grid[row][col])
      end
    end
  end
end

if $0 == __FILE__
  display = Display.new
  instructions = File.readlines('day6_input.txt').map { |line| display.parse_instruction line }
  instructions.each do |instr|
    coord1, coord2, action = instr
    display.flip(coord1, coord2, action)
  end
  p  display.count_lights
  display.grid.each do |row|
    puts row.join
  end
end
