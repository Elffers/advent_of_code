input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day14test.in").split("\n\n")
# input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day14.in").split("\n\n")

template = input.first
@rules = {}
input.last.split("\n").each do |x|
  p = x.split " -> "
  @rules[p.first] = p.last
end

# p rules
p template
def insert template 
new = ""
template.chars.each_cons(2) do |(a,b)|
  new += a + @rules[a+b]
end
new + template.chars.last
end

i = 0
40.times do
template = insert template
# p template.size
i += 1
p i
  p template.size
end
count = Hash.new 0
template.chars.each do |c|
  count[c] += 1
end
p count.values.max - count.values.min


