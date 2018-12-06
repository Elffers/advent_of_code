require 'pp'
points = File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day6.in").map { |x| x.strip.split(",").map { |n| n.to_i} }
# points = File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day6test.in").map { |x| x.strip.split(",").map { |n| n.to_i} }

# find distance between two points
def find_distance(a, b)
  x1, y1 = a
  x2, y2 = b
  (x1 - x2).abs + (y1 - y2).abs
end

# returns index of all points in input points closest to a
def find_closest(a, points)
  # distance => [all points at that distance from a]
  distances = Hash.new { |h, dist| h[dist] = [] }

  points.each.with_index do |pt, i|
    dist = find_distance(a, pt)
    distances[dist] << i
  end

  min = distances.keys.min

  # return all points at shortest distance from a
  distances[min]
end

# find outer bounds, find which points lie within those bounds
left, right = points.map { |x, y| x }.minmax
top, bottom = points.map { |x, y| y }.minmax

grid = Hash.new { |h, k| h[k] = [] }
infinite = {}
in_region = 0 # Part 2

# Populate grid with closest point(s)
(left..right).each do |x|
  (top..bottom).each do |y|
    pt = [x, y]

    closest_pts = find_closest(pt, points)
    grid[pt] = closest_pts

    if (x == left || x == right || y == top || y == bottom) && closest_pts.size == 1
      closest_pts.each do |c|
        infinite[c] = true
      end
    end

    # Part 2
    sum_dist = points.map{ |n| find_distance(pt, n) }.reduce(:+)
    in_region += 1 if sum_dist < 10000
  end
end

# count total points that are closest to input points
counts = Hash.new 0
grid.each do |pt, closest_to|
  if closest_to.size > 1
    next
  end
  point = closest_to.first
  counts[point] += 1 if !infinite[point]
end

bounded = (1...points.size).to_a - infinite.keys

areas = bounded.map do |x|
  counts[x]
end

p "Part 1: #{areas.max}"
p "Part 2: #{in_region}"
