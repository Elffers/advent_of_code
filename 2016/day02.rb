# --- Day 2: Bathroom Security ---

# You arrive at Easter Bunny Headquarters under cover of darkness. However, you left in such a rush that you forgot to use the bathroom! Fancy office buildings like this one usually have keypad locks on their bathrooms, so you search the front desk for the code.

# "In order to improve security," the document you find says, "bathroom codes will no longer be written down. Instead, please memorize and follow the procedure below to access the bathrooms."

# The document goes on to explain that each button to be pressed can be found by starting on the previous button and moving to adjacent buttons on the keypad: U moves up, D moves down, L moves left, and R moves right. Each line of instructions corresponds to one button, starting at the previous button (or, for the first line, the "5" button); press whatever button you're on at the end of each line. If a move doesn't lead to a button, ignore it.

# You can't hold it much longer, so you decide to figure out the code as you walk to the bathroom. You picture a keypad like this:

# 1 2 3
# 4 5 6
# 7 8 9
# Suppose your instructions are:

# ULL
# RRDDD
# LURDL
# UUUUD
# You start at "5" and move up (to "2"), left (to "1"), and left (you can't, and stay on "1"), so the first button is 1.
# Starting from the previous button ("1"), you move right twice (to "3") and then down three times (stopping at "9" after two moves and ignoring the third), ending up with 9.
# Continuing from "9", you move left, up, right, down, and left, ending with 8.
# Finally, you move up four times (stopping at "2"), then down once, ending with 5.
# So, in this example, the bathroom code is 1985.

# Your puzzle input is the instructions from the document you found at the front desk. What is the bathroom code?

class Decoder
  attr_accessor :instructions, :code

  KEYPAD = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
  ]

  KEYPAD_INDEX = {
    1 => [0, 0],
    2 => [0, 1],
    3 => [0, 2],
    4 => [1, 0],
    5 => [1, 1],
    6 => [1, 2],
    7 => [2, 0],
    8 => [2, 1],
    9 => [2, 2],
  }

  MIN = 0
  MAX = 2

  def initialize
    @code = []
  end

  def parse instructions
    @instructions = instructions.map { |x| x.strip.chars }
  end

  def decode start, instr
    x, y = KEYPAD_INDEX[start]

    while !instr.empty?
      move = instr.shift

      case move
      when "U"
        x -= 1 if x > MIN
        # p "current:", KEYPAD[x][y]
      when "D"
        x += 1 if x < MAX
        # p "current:", KEYPAD[x][y]
      when "L"
        y -= 1 if y > MIN
        # p "current:", KEYPAD[x][y]
      when "R"
        y += 1 if y < MAX
        # p "current:", KEYPAD[x][y]
      end
    end

    KEYPAD[x][y]
  end

  def find_code
    start = 5
    while !instructions.empty?
      instr = instructions.shift
      key = decode start, instr
      start = key
      code << key
    end

    code.join
  end

end

if $0 == __FILE__
  instructions = File.readlines('day02.in')

  d = Decoder.new
  d.parse instructions
  p d.find_code
end
