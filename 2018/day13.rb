require 'pp'
require 'set'

input = File.read("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day13.in").split("\n")
input = File.read("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day13test.in").split("\n")

DIR = {
  up: [0, -1],
  down: [0, 1],
  right: [1, 0],
  left: [-1, 0],
}

class Cart
  attr_accessor :x, :y, :dir, :turn

  TURN = [0, 1, 2] # left, straight, right

  def initialize(dir, x, y)
    @dir = dir
    @x = x
    @y = y
    @turn = 0 #index of turn
  end

  def turn_left
    dir = case @dir
          when DIR[:left]
            DIR[:down]
          when DIR[:right]
            DIR[:up]
          when DIR[:up]
            DIR[:left]
          when DIR[:down]
            DIR[:right]
          end

    self.dir = dir
  end

  def turn_right
    dir = case @dir
          when DIR[:left]
            DIR[:up]
          when DIR[:right]
            DIR[:down]
          when DIR[:up]
            DIR[:right]
          when DIR[:down]
            DIR[:left]
          end
    self.dir = dir
  end

  def change_dir
    case @dir
    when DIR[:left]
      if @turn == 0
        turn_left
      elsif @turn == 2
        turn_right
      end
    when DIR[:right]
      if @turn == 0
        turn_left
      elsif @turn == 2
        turn_right
      end
    when DIR[:up]
      if @turn == 0
        turn_left
      elsif @turn == 2
        turn_right
      end
    when DIR[:down]
      if @turn == 0
        turn_left
      elsif @turn == 2
        turn_right
      end
    end
    self.turn = (@turn + 1) % 3
  end

  def pos
    [@x, @y]
  end

  def current_dir
    case @dir
    when DIR[:left]
      :left
    when DIR[:right]
      :right
    when DIR[:up]
      :up
    when DIR[:down]
      :down
    end
  end

  def move
    self.x += dir.first
    self.y += dir.last
  end
end

carts = []
grid = Hash.new { |h, k| h[k] = Hash.new "" }

input.each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
    # find carts
    if %w[< > ^ v].include? char
      track = ""
      dir = case char
            when "<"
              track = "-"
              DIR[:left]
              # [-1, 0] # left
            when ">"
              track = "-"
              DIR[:right]
              # [1, 0] #right
            when "^"
              track = "|"
              DIR[:up]
              # [0, 1] #up
            when "v"
              track = "|"
              DIR[:down]
              # [0, -1] #down
            end
      cart = Cart.new(dir, x, y)
      carts << cart

      grid[x][y] = track
    else
      grid[x][y] = char
    end
  end
end

# p grid

t = 0
crashed = false
while !crashed
  positions = Set.new
  carts.each do |cart|
    p "position: #{cart.pos}, #{cart.current_dir}"
    cart.move
    track = grid[cart.x][cart.y]
    if track.empty? || track.nil?
      puts "ERROR"
      exit
    end
    case track
    when "\\"
      if cart.dir == [0, 1] # up
        cart.turn_left
      elsif cart.dir == [1, 0] # right
        cart.turn_right
      elsif cart.dir == [0, -1] # down
        cart.turn_left
      elsif cart.dir == [-1, 0] # left
        cart.turn_right
      end
    when "/"
      if cart.dir == [0, 1] # up
        cart.turn_right
      elsif cart.dir == [1, 0] # right
        cart.turn_left
      elsif cart.dir == [0, -1] # down
        cart.turn_right
      elsif cart.dir == [-1, 0] # left
        cart.turn_left
      end
    when "+"
      cart.change_dir
    end
    if positions.include? cart.pos
      p "Crashed at #{cart.pos}"
      crashed = true
      break
    else
      positions << cart.pos
      p positions
    end
  end
  t += 1
  p "tick: #{t}"
  puts
end
# 135, 23 wrong
# 23,135 wrong

# cart = carts.last
# p cart
# cart.change_dir
# p cart
# p "moving"
# cart.move
# p cart
# cart.change_dir
# p cart
# cart.change_dir
# p "moving"
# cart.move
# p cart
