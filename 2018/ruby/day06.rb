points = File.readlines("../inputs/day6.in").map { |x| x.strip.split(",").map { |n| n.to_i} }

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

  distances[min]
end

# find outer bounds, find which points lie within those bounds
left, right = points.map { |x, y| x }.minmax
top, bottom = points.map { |x, y| y }.minmax

infinite = {}
areas = Hash.new 0
in_region = 0 # Part 2

(left..right).each do |x|
  (top..bottom).each do |y|
    pt = [x, y]
    closest_pts = find_closest(pt, points)

    if closest_pts.size == 1
      coord = closest_pts.first
      areas[coord] += 1

      if (x == left || x == right || y == top || y == bottom)
        infinite[coord] = true
      end
    end

    # Part 2
    sum_dist = points.map{ |n| find_distance(pt, n) }.reduce(:+)
    in_region += 1 if sum_dist < 10000
  end
end

# count total points that are closest to input points
bounded = (1...points.size).to_a - infinite.keys

max_area = bounded.map do |x|
  areas[x]
end.max

p "Part 1: #{max_area}"
p "Part 2: #{in_region}"
