input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day12.in").split("\n")

x = y = deg =  0

input.each do |i|
  /(?<dir>\w)(?<n>\d+)/ =~ i
  n = n.to_i

  case dir
  when "E" then x += n
  when "N" then y += n
  when "W" then x -= n
  when "S" then y -= n
  when "L"
    deg = (deg+n) % 360
  when "R"
    deg = (deg-n) % 360
  when "F"
    case deg
    when 0 then x += n
    when 90 then y += n
    when 180 then x -= n
    when 270 then y -= n
    end
  end
end

p "part 1: #{x.abs+y.abs}"

# part 2
x, y = 0, 0
wx, wy = 10, 1

input.each do |i|
  /(?<dir>\w)(?<n>\d+)/ =~ i
  n = n.to_i

  case dir
  when "N" then wy += n
  when "S" then wy -= n
  when "E" then wx += n
  when "W" then wx -= n
  when "F"
    x += n*wx
    y += n*wy
  when "R"
    rot = n/90
    a, b = wx, wy
    rot.times do
      a, b = b, -a
    end
    wx, wy = a, b
  when "L"
    rot = n/90
    a, b = wx, wy
    rot.times do
      a, b = -b, a
    end
    wx, wy = a, b
  end
end

p "part 2: #{x.abs+y.abs}"
