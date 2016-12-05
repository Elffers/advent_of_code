# --- Day 3: Squares With Three Sides ---

# Now that you can think clearly, you move deeper into the labyrinth of
# hallways and office furniture that makes up this part of Easter Bunny HQ.
# This must be a graphic design department; the walls are covered in
# specifications for triangles.

# Or are they?

# The design document gives the side lengths of each triangle it describes,
# but... 5 10 25? Some of these aren't triangles. You can't help but mark the
# impossible ones.

# In a valid triangle, the sum of any two sides must be larger than the
# remaining side. For example, the "triangle" given above is impossible,
# because 5 + 10 is not larger than 25.

# In your puzzle input, how many of the listed triangles are possible?

# --- Part Two ---

# Now that you've helpfully marked up their design documents, it occurs to you
# that triangles are specified in groups of three vertically. Each set of
# three numbers in a column specifies a triangle. Rows are unrelated.

# For example, given the following specification, numbers with the same
# hundreds digit would be part of the same triangle:

# 101 301 501 102 302 502 103 303 503 201 401 601 202 402 602 203 403 603 In
# your puzzle input, and instead reading by columns, how many of the listed
# triangles are possible?

def valid_triangle? triple
  a, b, c = triple
  return false if a + b <= c
  return false if a + c <= b
  return false if b + c <= a

  true
end

def count_valid_triangles
  input = File.readlines('day03.in').map { |x|
    x.split(" ", 3).map { |n| n.to_i }
  }
  count = 0

  input.each do |triple|
    if valid_triangle? triple
      count += 1
    end
  end

  count
end

def count_valid_by_col input
  count = 0
  input.each_slice(3) do |slice| # 3 by 3
    a, b, c = slice

    triple1 = [a[0], b[0], c[0]]
    triple2 = [a[1], b[1], c[1]]
    triple3 = [a[2], b[2], c[2]]

    count += 1 if valid_triangle? triple1
    count += 1 if valid_triangle? triple2
    count += 1 if valid_triangle? triple3
  end

  count
end

def count_valid_from_stream
  count = 0
  File.foreach('day03.in') do |line|
    triple = line.split(" ", 3).map { |n| n.to_i }

    count += 1 if valid_triangle? triple
  end
  count
end

# if $0 == __FILE__
#   input = File.readlines('day03.in').map { |x| x.split(" ").map { |n| n.to_i } }
#   p count_valid_triangles input
#   p count_valid_by_col input
# end

require 'benchmark'
n = 1000
Benchmark.bmbm do |x|
  x.report { n.times { count_valid_triangles } }
  x.report { n.times { count_valid_from_stream } }
end
