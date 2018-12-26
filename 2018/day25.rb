
points = File.readlines("/Users/hsinghui/sandbox/advent_of_code/2018/inputs/day25.in").map { |x| x.strip.split(",").map { |d| d.to_i } }

# points = <<-POINTS
# 1,-1,0,1
# 2,0,-1,0
# 3,2,-1,0
# 0,0,3,1
# 0,0,-1,-1
# 2,3,-2,0
# -2,2,0,0
# 2,-2,0,-1
# 1,-1,0,-1
# 3,2,0,2
# POINTS
# points = points.split("\n").map {|x| x.split(",").map { |d| d.to_i } }
# pp points

class Constellation
  attr_accessor :pts

  def initialize pt
    @pts = [pt]
  end

  def join pt
    @pts << pt
  end

  def joinable? pt
    return false if @pts.empty?

    @pts.any? { |p| manhattan(p, pt) <= 3 }
  end

  def manhattan c1, c2
    dist = c1.zip(c2).map { |a, b| (a-b).abs }.reduce(:+)
    dist
  end
end

constellations = []

points.each do |pt|
  cluster = []

  constellations.each do |c|
    if c.joinable? pt
      cluster << c
    end
  end

  if cluster.size == 1
    cluster.first.join pt
  elsif cluster.size == 0
    c = Constellation.new pt
    constellations << c
  elsif cluster.size > 1
    c = Constellation.new pt
    cluster.each do |const|
      const.pts.each do |p|
        c.join p
      end
      constellations.delete const
    end
    constellations << c
  end
end

p "Part 1: #{constellations.size}"
