require 'pp'
input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day20.in").split("\n\n")
# input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day20test.in").split("\n\n")

class Tile
  attr_accessor :id, :img

  def initialize input
    x, y = input.split(":\n")
    @id = x.split(" ").last.to_i
    @img = y.split("\n")
  end

  def to_s(orientation=0)
    image = case orientation
    when 0 then img
    when 1 then img.map { |x| x.reverse }
    # when 2 then img
    # when 3 then img
    # when 4 then img
    # when 5 then img
    # when 6 then img
    # when 7 then img
    end

    puts image.join("\n")
  end

  def top
    @img.first
  end

  def bottom
    @img.last
  end

  def left
    @img.map { |row| row[0]}.join
  end

  def right
    @img.map { |row| row[-1] }.join
  end

  #[ t, b, l, r, tr, br, lr, rr]
  def edges
    x = [self.top, self.bottom, self.left, self.right]
    y = x.map { |n| n.reverse }
    x.concat y
  end

  def match? tile
    matches = []
    self.edges.each_with_index do |a, i|
      tile.edges.each_with_index do |b, j|
        if a == b
          matches << [i, j]
        end
      end
    end
    if matches.empty?
    return nil
    else
      return matches
    end
  end

end

tiles = input.map { |x| Tile.new x}

corners = []
config = Hash.new
tiles.each do |t1|
  config[t1.id] = Hash.new
  tiles.each do |t2|
    next if t1 == t2

    match = t1.match? t2
    if !match.nil?
      config[t1.id][t2.id] =  match
    end
  end

  if config[t1.id].size == 2
    corners << t1.id
  end
end

p "part 1: #{corners.reduce(:*)}"
corners.each do |c|
  p config[c]
end
# pp config


# 3 x 20
sm = <<-SEAMONSTER
                  #
#    ##    ##    ###
 #  #  #  #  #  #
SEAMONSTER


