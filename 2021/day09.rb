require 'set'
input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day09.in").split("\n").map { |x| x.chars.map { |c| c.to_i } }

@h = input.size
@w = input.first.size

# vertical and horizontal only
def neighbors x, y
  dirs = [
    [-1, 0], [0, -1], [0, 1], [1, 0]
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

lps = [] # coordinates of low points
input.each_with_index do |line, x|
  line.each_with_index do |n, y|
    ns = neighbors(x, y).map { |(i,j)| input[i][j] }
    if ns.min > n
      lps << [x,y]
    end
  end
end

p "Part 1: #{lps.map { |(i,j)| input[i][j]+1 }.sum}"

def find_basin x,y,input
  size = 0
  seen = Set.new
  queue = [[x,y]]
  while !queue.empty?
    curr = queue.shift
    i, j = curr
    ns = neighbors i, j
    if input[i][j] != 9 && !seen.include?(curr)
      size += 1
      seen << [i,j]
      queue.concat ns
    end
  end
  size
end

basins = []
lps.each do |pt|
  x, y = pt
  b = find_basin x, y, input
  basins << b
end

p "Part 2: #{basins.sort.reverse.take(3).reduce(:*)}"
