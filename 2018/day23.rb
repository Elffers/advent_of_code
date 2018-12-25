require 'pp'
require 'scanf'
input = File.readlines("/Users/hsinghui/sandbox/advent_of_code/2018/inputs/day23.in").map { |x| x.strip }
# input = <<-INPUT
# pos=<0,0,0>, r=4
# pos=<1,0,0>, r=1
# pos=<4,0,0>, r=3
# pos=<0,2,0>, r=1
# pos=<0,5,0>, r=3
# pos=<0,0,3>, r=1
# pos=<1,1,1>, r=1
# pos=<1,1,2>, r=1
# pos=<1,3,1>, r=1
# INPUT
# input = input.split("\n")

max = 0
origin = nil
bots = {}

input.each do |line|
  x, y, z, r = line.scanf("pos=<%d,%d,%d>, r=%d")
  bots[[x, y, z]] = r
  if r > max
    max = r
    origin = [x, y, z]
  end
end

count = 0
bots.each do |coords, r|
  sum = coords.zip(origin).map { |a, b| (a-b).abs}.reduce(:+)
  count += 1 if sum <= max
end

p "Part 1: #{count}"
