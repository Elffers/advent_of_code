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


def hash input
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

i = 0
count = 0

128.times do
  row = "#{input}-#{i.to_s}"
  knot_hash = hash row

  hex = knot_hash.chars.map do |x|
    format "%04b", x.to_i(16)
  end.join

  count += hex.count("1")
  i += 1
end

p count
