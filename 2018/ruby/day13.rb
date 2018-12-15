require 'pp'

input = File.read("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day13.in")
# print input
input =input.split("\n")
# input = File.read("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day13test.in").split("\n")

DIR = {
  up: [0, -1],
  down: [0, 1],
  right: [1, 0],
  left: [-1, 0],
}

class Cart
  attr_accessor :x, :y, :dir, :turn, :alive

  TURN = [0, 1, 2] # left, straight, right

  def initialize(dir, x, y)
    @dir = dir
    @x = x
    @y = y
    @turn = 0 #index of turn
    @alive = true
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
    if @turn == 0
      turn_left
    elsif @turn == 2
      turn_right
    end
    self.turn = (@turn + 1) % 3
  end

  def pos
    [@x, @y]
  end

  # for debugging only
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
            when ">"
              track = "-"
              DIR[:right]
            when "^"
              track = "|"
              DIR[:up]
            when "v"
              track = "|"
              DIR[:down]
            end
      cart = Cart.new(dir, x, y)
      carts << cart

      grid[x][y] = track
    else
      grid[x][y] = char
    end
  end
end

alive = carts.size
while alive > 1
  carts.sort_by! { |cart| cart.pos }
  current_positions = carts.map do |c|
    c.alive ? c.pos : nil
  end

  carts.each_with_index do |cart, i|
    if cart.alive
      cart.move

      track = grid[cart.x][cart.y]
      if track.empty? || track.nil?
        puts "ERROR"
        exit
      end
      case track
      when "\\"
        if cart.dir == DIR[:up]
          cart.turn_left
        elsif cart.dir == DIR[:down]
          cart.turn_left
        elsif cart.dir == DIR[:right]
          cart.turn_right
        elsif cart.dir == DIR[:left]
          cart.turn_right
        end
      when "/"
        if cart.dir == DIR[:up]
          cart.turn_right
        elsif cart.dir == DIR[:down]
          cart.turn_right
        elsif cart.dir == DIR[:right]
          cart.turn_left
        elsif cart.dir == DIR[:left]
          cart.turn_left
        end
      when "+"
        cart.change_dir
      end

      if current_positions.include? cart.pos
        if alive == 17
          p "Part 1: #{cart.pos}"
        end

        cart.alive = false
        current_positions[i] = nil

        j = current_positions.find_index(cart.pos)
        current_positions[j] = nil
        carts[j].alive = false

        alive = carts.select { |c| c.alive }.size
      else
        current_positions[i] = cart.pos
      end
    end
  end
end

p "Part 2: #{carts.select { |c| c.alive }.first.pos}"
