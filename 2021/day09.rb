require 'set'
input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day09.in").split("\n").map { |x| x.chars.map { |c| c.to_i }}

@h = input.size
@w = input.first.size

def neighbors x, y, input
  ns = []
  if x - 1 >= 0
    ns << input[x-1][y]
  end
  if y - 1 >= 0
    ns << input[x][y-1]
  end
  if x + 1 < @h
    ns << input[x+1][y]
  end
  if y + 1 < @w
    ns << input[x][y+1]
  end
  ns
end

lp = []
lps = [] #coordinates of low points
input.each_with_index do |line, x|
  line.each_with_index do |n, y|
    ns = neighbors x, y, input
    if ns.min > n
      lp << n
      lps << [x,y]
    end
  end
end

p "Part 1: #{lp.map { |x| x+1 }.sum}"

def ncoords x, y
  ns = []
  if x - 1 >= 0
    ns << [x-1,y]
  end
  if y - 1 >= 0
    ns << [x,y-1]
  end
  if x + 1 < @h
    ns << [x+1,y]
  end
  if y + 1 < @w
    ns << [x,y+1]
  end
  ns
end

def find_basin x,y,input
  size = 0
  seen = Set.new
  queue = [[x,y]]
  while !queue.empty?
    curr = queue.shift
    i, j = curr
    ns = ncoords i, j
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
