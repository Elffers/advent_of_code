input = File.read("../day10.in").chomp
lengths = input.split(",").map { |x| x.to_i }
list = (0..255).to_a

pos = 0
skip = 0

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

result = knot(lengths, list, pos, skip)
l = result.first

p l[0] * l[1]

# Part 2

ascii = input.chars.map { |x| x.ord }
tail = [17, 31, 73, 47, 23]
lengths = ascii.concat tail

pos = 0
skip = 0

64.times do
  list, pos, skip = knot(lengths, list, pos, skip)
end

dense = list.each_slice(16).map do |slice|
  slice.reduce(:^)
end

knot_hash = dense.map { |num| num.to_s 16 }.join

p knot_hash

# a9d0e68649d0174c8756a59ba21d4dc6
