input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day14.in").split("\n\n")

template = input.first
@rules = {}
input.last.split("\n").each do |x|
  p = x.split " -> "
  @rules[p.first] = p.last
end

def count_pairs pcs, last
  pair_counts = Hash.new 0
  cts = Hash.new 0
  cts[last] += 1

  pcs.each do |pair,v|
    c = @rules[pair]
    x = pair[0]
    y = pair[1]
    cts[c] += v
    cts[x] += v

    new_pair = x + c
    pair_counts[new_pair] += v
    new_pair = c + y
    pair_counts[new_pair] += v
  end
  [pair_counts, cts]
end

pairs = Hash.new 0
counts = Hash.new 0
cs = template.chars

cs.each_cons(2) do |p|
  pairs[p.join] += 1
end

cs.each do |c|
  counts[c] += 1
end

i = 0
x = template.chars.last # last character always the same
40.times do
  pairs, cts = count_pairs pairs, x
  i += 1
  if i == 10
    puts "Part 1: #{cts.values.max - cts.values.min}"
  end
  if i == 40
    puts "Part 2: #{cts.values.max - cts.values.min}"
  end
end
