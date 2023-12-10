require 'benchmark'
maps = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day05.in").split("\n\n")
# maps = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day05_test.in").split("\n\n")

seeds = maps.shift.split(": ").last.split.map { |x| x.to_i }

def check_lists s, lists
  lists.each do |(dest, src, len)|
    if s >= src && s < (src+len)
      diff = s-src
      return dest + diff
    end
  end
  nil
end

def transform input, lists, f
  input.map do |s|
    (method(f).call(s, lists)) || s
  end
end

def check_ranges input, lists
  out = []
  queue = []
  input.each_slice(2) do |pair|
    queue << pair
  end
  p queue
  while !queue.empty?
    x0, r = queue.shift

    xn = x0+r-1

    overlap = false
    lists.each do |(dest, s0, len)|
      sn = s0+len-1

      if x0 > sn || xn < s0
        next #skip to next list
      end
      # whole input range is subset of list
      if s0 <= x0 && xn <= sn
        overlap = true

        offset = x0-s0
        y0 = dest + offset
        p "WHOLE RANGE: #{[x0, xn]}"
        p "source range: #{ [s0, sn]}, dest: #{dest}, offset: #{offset}}"
        out << y0
        out << r
        puts
      elsif s0 <= x0 # map front, put back into queue
        overlap = true
        p "MAPPING FRONT #{[x0, xn]}"
        offset = x0-s0
        y1 = dest + offset
        r1 = sn-x0+1
        p "source range: #{ [s0, sn]}, dest: #{dest}}"
        p "front range: #{[y1, r1]}"
        out << y1
        out << r1

        y2 = x0+r1
        r2 = r - r1
        p "back range: #{[y2, r2]}"
        queue << [y2, r2]
        puts

      elsif xn <= sn # map back, keep front
        overlap = true
        p "MAPPING BACK #{[x0, xn]}"
        offset = s0-x0
        y1 = x0
        r1 = offset
        p "source range: #{ [s0, sn]}, dest: #{dest}}"
        p "front range: #{[y1, r1]}"
        queue << [y1, r1]
        y2 = dest+offset
        r2 = r-offset
        p "back range: #{[y2, r2]}"
        out << y2
        out << r2
        puts
      end
    end
    if !overlap
      p "NO MAPPING #{[x0, r]}"
      out << x0
      out << r
    end
  end
  out
end

# input array, return array
def src_to_dest data, input
  lists = data.split("\n")
  p lists.shift # remove header
  lists = lists.map { |list| list.split.map { |x| x.to_i } }

  # transform(input, lists, f)
  check_ranges(input, lists)
end

def run maps, input
  src = input
  while !maps.empty?
    m = maps.shift
    src = src_to_dest m, src
    p "OUTPUT: #{src}"
    puts
  end
  src.each_slice(2).map { |x| x.first }.min
end

Benchmark.bm do |x|
  # x.report {p "Part 1: #{run maps, seeds, :check_lists}" }
  x.report {p "Part 2: #{run maps, seeds}" }
end
