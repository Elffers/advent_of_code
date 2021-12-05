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
  end
  if y1 == y2
    min, max = [x1, x2].minmax
    (min..max).each do |x|
      pts[[x,y1]] += 1
    end
  end
end
p pts.values.count { |v| v > 1 }
