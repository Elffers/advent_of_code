require 'pp'

input = File.readlines("../day21.in").map { |x| x.chomp.tr("/", "\n") }

# input = <<TEST
# ../.# => ##./#../...
# .#./..#/### => #..#/..../..../#..#
# TEST
# input = input.split("\n").map { |x| x.chomp.tr("/", "\n") }

$rules = {}

input.each do |line|
  k, v = line.split " => "
  $rules[k] = v
end

def rotate input
  a = input.dup
  a = a.split("\n").map { |x| x.reverse.chars }
  a.transpose.map { |x| x.join }.join "\n"
end

def flips input
  grid = input.dup.split "\n"
  a = grid.reverse.join "\n"
  b = grid.reverse.map { |x| x.reverse }.join "\n"
  c = grid.map { |x| x.reverse }.join "\n"
  [a, b, c]
end

def keys_for input
  out = [input]
  out.concat(flips input)
  a = input.dup
  4.times do
    a = rotate a
    b = flips a
    out << a
    out.concat b
  end
  out.uniq
end

grid = <<INIT
.#.
..#
###
INIT

def convert grid
  keys = keys_for grid
  rule = keys.find do |key|
    !$rules[key].nil?
  end

  $rules[rule]
end

def enhance grid
  grid = grid.split "\n"
  if grid.size.even?
    grid = partition grid, 2
  elsif grid.size % 3 == 0
    grid = partition grid, 3
  end
  grid
end

def partition grid, n
  blocks = []
  grid.each_slice(n) do |rows|
    block_row = []
    (0...grid.size).step n do |x|
      block = []
      rows.each do |row|
        block << row[x, n]
      end
      block = convert(block.join("\n"))
      block_row << block
    end
    block_row = join block_row
    blocks << block_row
  end
  blocks.join "\n"
end

def join block_row
  transposed = block_row.map { |block| block.split "\n" }.transpose
  transposed.map { |x| x.join }.join "\n"
end

grid = grid.chomp
18.times do
  grid = enhance(grid)
end

p grid.count "#"

