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

  def to_s(img=@img)
    puts img.join("\n")
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
    self.edges.each_with_index do |a, i|
      tile.edges.each_with_index do |b, j|
        if a == b
          return [i, j]
        end
      end
    end
    return
  end

end

tiles = input.map { |x| Tile.new x}

corners = []
options = Hash.new
tiles.each do |t1|
  options[t1.id] = Hash.new
  tiles.each do |t2|
    next if t1 == t2

    match = t1.match? t2
    if !match.nil?
      options[t1.id][t2.id] =  match
    end
  end

  if options[t1.id].size == 2
    corners << t1.id
  end
end

p "part 1: #{corners.reduce(:*)}"
