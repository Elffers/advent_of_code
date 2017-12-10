lengths = File.read("../day10.in").strip.split(",").map { |x| x.to_i }
s = (0..255).to_a

# lengths = [3, 4, 1, 5]
# s = (0..4).to_a

size = s.size
pos = 0
skip = 0

while !lengths.empty?
  len = lengths.shift
  s = s.cycle(2).to_a

  sublist = s[pos, len]
  p sublist: sublist
  sublist.reverse!

  cdr_start = (pos + len) % size
  cdr_end = size - len
  cdr = s[cdr_start, cdr_end]
  p cdr: cdr

  s = sublist.concat cdr
  p s_before: s
  s = s.rotate(-pos)
  p s: s

  pos = (pos + len + skip)%size
  p pos: pos
  p "==============\n"
  skip += 1
end

p s[0] * s[1]
# 43890 too high
