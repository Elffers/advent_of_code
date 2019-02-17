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

input = <<-INPUT
pos=<10,12,12>, r=2
pos=<12,14,12>, r=2
pos=<16,12,12>, r=4
pos=<14,14,14>, r=6
pos=<50,50,50>, r=200
pos=<10,10,10>, r=5
INPUT
input = input.split("\n")

max_range = 0
origin = nil
bots = {}
input.each do |line|
  x, y, z, r = line.scanf("pos=<%d,%d,%d>, r=%d")
  bots[[x, y, z]] = r
  if r > max_range
    max_range = r
    origin = [x, y, z]
  end
end

xs = []
ys = []
zs = []

bots.keys.each do |x, y, z|
  xs << x
  ys << y
  zs << z
end
p "x: #{xs.minmax}"
p "y: #{ys.minmax}"
p "z: #{zs.minmax}"

def manhattan(c1, c2)
  c1.zip(c2).map { |a, b| (a-b).abs}.reduce(:+)
end

def bots_in_range(origin, range, bots)
  count = 0
  bots.each do |coords, r|
    dist = manhattan(coords,origin)
    count += 1 if dist <= range
  end
  count
end

count = bots_in_range(origin, max_range, bots)

p "Part 1: #{count}"

# max_in_range = 0
# most_popular_bots = Hash.new { |h, k| h[k] = [] }
# ranges = []

# count of coordinates in range of a bot
# ranges = Hash.new do |x, y|
#   x[y] = Hash.new { |h, z| h[z] = Hash.new 0  }
# end
# ranges[0][0][0] = 1
# p ranges

# bots.each do |origin, range|
#   # count = bots_in_range(origin, range, bots)
#   x, y, z = origin
#   (x-range..x+range).each do |i|
#     (y-range..y+range).each do |j|
#       (z-range..z+range).each do |k|
#         ranges[i][j][k] += 1
#       end
#     end
#   end
#   pp ranges
# end
# p ranges

# pp most_popular_bots
# p ranges.max

# min = most_popular_bots.map do |bot|
#   manhattan([0, 0, 0], bot)
# end.min
# p min
# 85592444 too low
