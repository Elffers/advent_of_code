# lengths = File.read("../day10.in").strip.split(",").map { |x| x.to_i }
# s = (0..255).to_a

lengths = [3, 4, 1, 5]
s = (0..4).to_a

def twist lengths, s
  size = s.size
  pos = 0
  skip = 0

  while !lengths.empty?
    len = lengths.shift
    s = s.cycle(2).to_a

    sublist = s[pos, len]
    # p sublist: sublist
    sublist.reverse!

    cdr_start = (pos + len) % size
    cdr_end = size - len
    cdr = s[cdr_start, cdr_end]
    # p cdr: cdr

    s = sublist.concat cdr
    s = s.rotate(-pos)
    # p s: s

    pos = (pos + len + skip)%size
    # p pos: pos
    skip += 1
  end
  [s, pos, skip]
end

result = twist(lengths, s)
p result
s = result.first

p s[0] * s[1]

