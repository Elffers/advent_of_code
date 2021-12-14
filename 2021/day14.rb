input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day14test.in").split("\n\n")
input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day14.in").split("\n\n")

template = input.first
@rules = {}
input.last.split("\n").each do |x|
  p = x.split " -> "
  @rules[p.first] = p.last
end

def insert template
  counts = Hash.new 0
  cs = template.chars
  cs.each do |c|
    counts[c] += 1
  end
  new = ""
  cs.each_cons(2) do |(a,b)|
    v = @rules[a+b]
    new += a + v
    counts[v] += 1
  end
  new + template.chars.last
end

# part 2

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
  puts "COUNTS: #{cts.values.max - cts.values.min}"
  pair_counts
end

pairs = Hash.new 0
cs = template.chars
cs.each_cons(2) do |p|
  pairs[p.join] += 1
end

counts = Hash.new 0
cs.each do |c|
  counts[c] += 1
end

p "START"
p pairs, counts
puts
x = template.chars.last
40.times do
  pairs, count = count_pairs pairs, x
  # p pairs
  # puts
end

i = 0
# 10.times do
#   template = insert template
#   i += 1
#   p [i, template.size]
# end

# count = Hash.new 0
# template.chars.each do |c|
#   count[c] += 1
# end
# p count.values.max - count.values.min
