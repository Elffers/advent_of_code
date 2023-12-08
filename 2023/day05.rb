require 'pp'
maps = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day05.in").split("\n\n")
# maps = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day05_test.in").split("\n\n")

seeds = maps.shift.split(": ").last.split.map { |x| x.to_i }
p "Seeds: #{seeds}"

# input array, return array
def src_to_dest data, sources
  lists = data.split("\n")
  lists.shift # remove header
  lists = lists.map { |list| list.split.map { |x| x.to_i } }

  mapping = {}
  lists.each do |list|
    dest = list.shift
    src = list.shift
    len = list.shift
    i = 0
    while i <= len
      mapping[src+i] = dest + i
      i += 1
    end
  end
  sources.map { |x| mapping[x] || x }
end

src = seeds
while !maps.empty?
  m = maps.shift
  src = src_to_dest m, src
end
p src.min
