input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day05.in").split("\n")
# input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day05test.in").split("\n")
pts = Hash.new 0
input.each do |i|
  a, b = i.split(" -> ")
  x1, y1 = a.split(",").map { |x| x.to_i }
  x2, y2 = b.split(",").map { |x| x.to_i }
  if x1 == x2
    min, max = [y1, y2].minmax
    (min..max).each do |y|
      pts[[x1,y]] += 1
    end
  elsif y1 == y2
    min, max = [x1, x2].minmax
    (min..max).each do |x|
      pts[[x,y1]] += 1
    end
  else
    slope = (x1-x2)/(y1-y2)
    ymin, ymax = [y1, y2].minmax
    xmin, xmax = [x1, x2].minmax
    if slope == 1
      (xmin..xmax).to_a.zip((ymin..ymax).to_a).each do |pt|
          pts[pt] += 1
      end
    elsif slope == -1
      (xmin..xmax).to_a.zip((ymin..ymax).to_a.reverse).each do |pt|
          pts[pt] += 1
      end
    end
  end
end
p pts.values.count { |v| v > 1 }
