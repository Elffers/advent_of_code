require 'pp'
input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day22test.in").map { |x| x.chomp }
input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day22test2.in").map { |x| x.chomp }
input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day22.in").map { |x| x.chomp }

cs = Hash.new
input.each do |instr|
  /(?<op>(on|off)) x=(?<x1>\d+)..(?<x2>\d+),y=(?<y1>\d+)..(?<y2>\d+),z=(?<z1>\d+)..(?<z2>\d+)/ =~ instr
  instr = instr.split
  op, ds = instr
  ds = ds.split(",").map do |d|
    foo = d.split "="
    axis, range = foo
    range.split("..").map { |r| r.to_i }
  end
  x1, x2 = ds[0]
  y1, y2 = ds[1]
  z1, z2 = ds[2]
  if x1 < -50 || x2 > 50 ||
      y1 < -50 || y2 > 50 ||
      z1 < -50 || z2 > 50
    next
  else
    (x1..x2).each do |x|
      (y1..y2).each do |y|
        (z1..z2).each do |z|
          cs[[x,y,z]] = op
        end
      end
    end
  end
end
# pp cs

count = 0
cs.each_pair do |k, v|
  if v == "on"
    count += 1
  end
end
p "Part 1: #{count}"
