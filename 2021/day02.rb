input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day02.in").split("\n")

x, y = 0, 0
x2, y2, a = 0, 0, 0

input.each do |i|
  dir, d = i.split " "
  d = d.to_i
  case dir
  when "forward"
    x += d
    x2 += d
    y2 += a*d
  when "down"
    y += d
    a += d
  when "up"
    y -= d
    a -= d
  end
end

p "Part 1: #{x*y}"
p "Part 2: #{x2*y2}"
