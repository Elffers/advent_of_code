require 'pp'
maps = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day05.in").split("\n\n")
maps = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day05_test.in").split("\n\n")

seeds = maps.shift.split(": ").last.split.map { |x| x.to_i }

def check_lists s, lists
  lists.each do |list|
    dest = list[0]
    src = list[1]
    len = list[2]
    if s >= src && s < (src+len)
      diff = s-src
      return dest + diff
    end
  end
  nil
end

# input array, return array
def src_to_dest data, sources
  lists = data.split("\n")
  p lists.shift # remove header
  lists = lists.map { |list| list.split.map { |x| x.to_i } }

  out = sources.map do |s|
    check_lists(s, lists) || s
  end
  out
end

src = seeds
while !maps.empty?
  # p src
  m = maps.shift
  src = src_to_dest m, src
end
p "Part 1: #{src.min}"
