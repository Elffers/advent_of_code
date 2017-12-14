require 'pp'
require 'set'

def knot lengths, list, pos, skip
  lens = lengths.dup

  size = list.size

  while !lens.empty?
    len = lens.shift
    list = list.cycle(2).to_a

    sublist = list[pos, len]
    sublist.reverse!

    cdr_start = (pos + len) % size
    cdr_end = size - len
    cdr = list[cdr_start, cdr_end]

    list = sublist.concat cdr
    list = list.rotate(-pos)

    pos = (pos + len + skip)%size
    skip += 1
  end
  [list, pos, skip]
end

def knothash input
  ascii = input.chars.map { |x| x.ord }
  tail = [17, 31, 73, 47, 23]
  lengths = ascii.concat tail
  list = (0..255).to_a

  pos, skip = 0, 0

  64.times do
    list, pos, skip = knot(lengths, list, pos, skip)
  end

  dense = list.each_slice(16).map do |slice|
    slice.reduce(:^)
  end

  dense.map { |num| format "%02x", num }.join
end

input = "hfdlxzhv"

n = 0
count = 0
rows = []
128.times do
  row = "#{input}-#{n.to_s}"
  knot_hash = knothash row

  binary = knot_hash.chars.map do |x|
    format "%04b", x.to_i(16)
  end.join

  rows << binary

  count += binary.count("1")
  n += 1
end

p "Part 1: #{count}"

def neighbors i, j
  coords = [
    [1, 0], [-1, 0], [0, 1], [0, -1]
  ]

  coords.map do |x, y|
    [i + x, j + y]
  end
end

# test = <<TEST
# 11010100
# 01010101
# 00001010
# 10101101
# 01101000
# 11001001
# 01000100
# 11010110
# TEST
# rows = test.split "\n"
# pp rows: rows

unseen = Set.new
rows.each_with_index do |row, i|
  row.chars.each_with_index do |char, j|
    if char == "1"
      unseen << [i, j]
    end
  end
end

p unseen

regions = 0
until unseen.empty?
  queue = []
  queue.push unseen.first
  until queue.empty?
    x, y = queue.shift
    if unseen.include?([x, y])
      unseen.delete([x, y])
      queue.concat neighbors(x, y)
    end
  end
  regions += 1
end

p "Part 2: #{regions}"
