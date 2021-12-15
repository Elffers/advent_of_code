input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day15test.in").split("\n").map { |x| x.chars.map { |c| c.to_i }}
input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day15.in").split("\n").map { |x| x.chars.map { |c| c.to_i }}

# vertical and horizontal only
def adj x, y, input
  h = input.size
  w = input.first.size
  dirs = [
    [-1, 0], [0, -1], [0, 1], [1, 0]
  ]
  ns = []
  dirs.each do |(i,j)|
    dx, dy = x+i, y+j
    if (0 <= dx && dx < h) && (0 <= dy && dy < w)
      ns << [dx, dy]
    end
  end
  ns
end

def shortest_path input
  h = input.size
  w = input.first.size
  memo = Array.new(h) { Array.new w }
  memo[0][0] = 0
  (0...w).each do |j|
    next if j == 0
    memo[0][j] = memo[0][j-1] + input[0][j]
  end
  (0...h).each do |i|
    next if i == 0
    memo[i][0] = memo[i-1][0] + input[i][0]
  end

  (1...h).each do |i|
    (1...w).each do |j|
      ns = adj i, j, input
      v = ns.map { |(x, y)| memo[x][y] }
      memo[i][j] = input[i][j] + v.compact.min
    end
  end
  # memo.each do |m|
  #   p m
  # end
  memo[h-1][w-1]
end

p "Part 1: #{shortest_path input}"

p2 = Array.new(5) { Array.new(5) }

def inc input, i
  x = (1..9).to_a
  input.map do |r|
    r.map do |v|
      x = (v+i) %9
      if x == 0
        x = 9
      end
      x
    end
  end
end

i = 0
p2.each_with_index do |row, x|
  row.each_with_index do |t, y|
    i = x + y
    t = inc input, i
    p2[x][y] = t
  end
end

h = input.size
w = input.first.size

p3 = Array.new

# each p2 row is first five rows of p3
r = 0
p2.each_with_index do |row, i|
  (0..9).each do |ti|
    new_row =  row.map { |t| t[ti] }.flatten
    p3[r] = new_row
    r += 1
  end
end

# p "p3"
p3.each do |x|
  p x
end

p "Part 2: #{shortest_path p3}"
