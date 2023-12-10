require 'benchmark'

input = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day06.in").split("\n")
times = input.first.split(/Time:\s+/).last.split(/\s+/).map { |x| x.to_i }
distances = input.last.split(/Distance:\s+/).last.split(/\s+/).map { |x| x.to_i }

records =  times.zip distances

times2 = times.map { |x| x.to_s}.join.to_i
distances2 = distances.map { |x| x.to_s}.join.to_i
record2 =  [times2, distances2]

def ways_to_beat record
  time, distance = record
  i = 1
  count = 0
  while i <= time/2
    v = i
    t = time - i
    d = v*t
    if d > distance
      count += time/2-i + 1
      count *= 2
      break
    end
    i += 1
  end

  if time.even?
    count -= 1
  end
  count
end

ways = records.map do |record|
  ways_to_beat record
end

Benchmark.bm do |x|
  x.report { p "Part 1: #{ways.reduce(:*)}"}
  x.report { p "Part 2: #{ways_to_beat record2}" }
end

