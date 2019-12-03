wires = File.readlines("./inputs/day03.in")
# wires = ["R8,U5,L5,D3", "U7,R6,D4,L4"]
# wires = ["R75,D30,R83,U83,L12,D49,R71,U7,L72", "U62,R66,U55,R34,D71,R55,D58,R83"]
# wires = ["R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51", "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"]


def coords_for wire
  coords = {}
  x, y = 0, 0
  steps = 0

  wire.split(",").each do |turn|
    /(?<dir>[R,L,U,D])(?<len>\d+)/ =~ turn
    len = len.to_i

    case dir
    when "R"
     target = x + len
      until x == target
        x += 1
        steps += 1
        if coords[[x, y]].nil?
          coords[[x, y]] = steps
        end
      end
    when "L"
      target = x - len
      until x == target
        x -= 1
        steps += 1
        if coords[[x, y]].nil?
          coords[[x, y]] = steps
        end
      end
    when "U"
      target = y + len
      until y == target
        y += 1
        steps += 1
        if coords[[x, y]].nil?
          coords[[x, y]] = steps
        end
      end
    when "D"
      target = y - len
      until y == target
        y -= 1
        steps += 1
        if coords[[x, y]].nil?
          coords[[x, y]] = steps
        end
      end
    end
  end
  coords
end

def closest_intersection w1, w2
  intersections = w1.keys & w2.keys
  min = intersections.map do |x, y|
    x.abs + y.abs
  end.min

  min_steps = intersections.map do |i|
    w1[i] + w2[i]
  end.min

  p "Part 1: #{min}"
  p "Part 2: #{min_steps}"
end


w1, w2 = wires.map do |wire|
  coords_for wire
end

closest_intersection w1, w2
