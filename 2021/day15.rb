# input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day15test.in").split("\n").map { |x| x.chars.map { |c| c.to_i }}
input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day15.in").split("\n").map { |x| x.chars.map { |c| c.to_i }}
#
@h = input.size
@w = input.first.size

# vertical and horizontal only
def adj x, y
  dirs = [
    [-1, 0], [0, -1], [0, 1], [1, 0]
    # [0, -1], [1, 0]
  ]
  ns = []
  dirs.each do |(i,j)|
    dx, dy = x+i, y+j
    if (0 <= dx && dx < @h) && (0 <= dy && dy < @w)
      ns << [dx, dy]
    end
  end
  ns
end

def shortest_path input
  memo = Array.new(@h) { Array.new @w }
  memo[0][0] = 0
  (0...@w).each do |j|
    next if j == 0
    memo[0][j] = memo[0][j-1] + input[0][j-1]
  end
  (0...@h).each do |i|
    next if i == 0
    memo[i][0] = memo[i-1][0] + input[i-0][0]
  end

  (1...@h).each do |i|
    (1...@w).each do |j|
      ns = adj i, j
      v = ns.map { |(x, y)| memo[x][y] }
      memo[i][j] = input[i][j] + v.compact.min
    end
  end
  memo.each do |m|
    p m
  end
  memo[@h-1][@w-1]
end

p shortest_path input

