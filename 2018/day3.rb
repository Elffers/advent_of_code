require 'pp'
input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day3.in")
# input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day3test.in")

claims = []
#1 @ 1,3: 4x4

input.map do |line|
  /(?<id>\d+) @ (?<x>\d+),(?<y>\d+): (?<w>\d+)x(?<l>\d+)/ =~ line
  claim = {
    id: id.to_i,
    x: x.to_i,
    y: y.to_i,
    width: w.to_i,
    length: l.to_i
  }
  claims << claim
  # id, line.split(" @ ").last.strip
end

cloth = Hash.new{ |h, k| h[k] = Hash.new 0 }

overlaps = 0
claims.each do |claim|
  x, y, w, l = claim[:x], claim[:y], claim[:width], claim[:length]
  p [x, y, w, l]
  (x...x+w).each do |i|
    (y...y+l).each do |j|
      cloth[j][i] += 1
    end
  end

  # p "CLOTH: "
  # pp cloth
# p "overlaps: #{overlaps}"
end

cloth.each do |col, row|
  row.each do |pt, val|
    if val > 1
      overlaps += 1
    end
  end
end

p overlaps
