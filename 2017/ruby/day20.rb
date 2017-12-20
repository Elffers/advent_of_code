require 'pp'

input = File.readlines("../day20.in").map { |x| x.chomp }
# input = <<TEST
# p=< 3,0,0>, v=< 2,0,0>, a=<-1,0,0>
# p=< 4,0,0>, v=< 0,0,0>, a=<-2,0,0>
# TEST
# input = input.split("\n")

class Point
  attr_accessor :pt, :v, :a, :dist

  def initialize pt, v, a
    @pt = pt
    @v = v
    @a = a
    @dist = pt.map { |x| x.abs }.reduce(:+)
  end

  def step
    self.v = v.zip(a).map { |v, a| v + a }
    self.pt = pt.zip(v).map { |pt, v| pt + v }
    self.dist = pt.map { |x| x.abs }.reduce(:+)
  end

end

points = []
input.each do |line|
  pt, v, a = line.split ", "
  pt, v, a = [pt, v, a].map do |x|
    x.scan(/(-?\d+),(-?\d+),(-?\d+)/).first.map { |n| n.to_i }
  end
  points << Point.new(pt, v, a)
end

mins = Array.new(points.size)

loop do
  points.each_with_index do |point, i|
    point.step
    mins[i] = point.dist
  end
  m = mins.min
  p min: m, i: mins.index(m)
end
