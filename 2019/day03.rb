require 'set'

wires = File.readlines("./inputs/day03.in")

def coords_for wire
  coords = Set.new
  x, y = 0, 0
  wire.split(",").each do |turn|
    /(?<dir>[R,L,U,D])(?<len>\d+)/ =~ turn
    len = len.to_i
    case dir
    when "R"
      (x..x+len).each do |pt|
        coords << [pt, y]
      end
      x += len
    when "L"
      (x-len..x).each do |pt|
        coords << [pt, y]
      end
      x -= len
    when "U"
      (y..y+len).each do |pt|
        coords << [x, pt]
      end
      y += len
    when "D"
      (y-len..y).each do |pt|
        coords << [x, pt]
      end
      y -= len
    end
  end
  coords.delete [0,0]
  coords
end

def closest_intersection w1, w2
  intersections = w1 & w2
  intersections.map do |x, y|
    x.abs + y.abs
  end.min
end

w1, w2 = wires.map do |wire|
  coords_for wire
end

p "Part 1: #{closest_intersection w1, w2}"
