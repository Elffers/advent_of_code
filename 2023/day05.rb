require 'benchmark'
maps = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day05.in").split("\n\n")
# maps = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day05_test.in").split("\n\n")

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

# def check_ranges input, lists
#   lists.each do |list|
#   end
# end

# input array, return array
def src_to_dest data, input, f
  lists = data.split("\n")
  lists.shift # remove header
  lists = lists.map { |list| list.split.map { |x| x.to_i } }

  out = input.map do |s|
    (method(f).call(s, lists)) || s
  end
  out
end

def run maps, input, f
  src = input
  while !maps.empty?
    m = maps.shift
    src = src_to_dest m, src, f
  end
  src.min
end

Benchmark.bm do |x|
  x.report {p "Part 1: #{run maps, seeds, :check_lists}" }
end
