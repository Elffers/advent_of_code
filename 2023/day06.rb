input = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day06.in").split("\n")
times = input.first.split(/Time:\s+/).last.split(/\s+/).map { |x| x.to_i }
distances = input.last.split(/Distance:\s+/).last.split(/\s+/).map { |x| x.to_i }

records =  times.zip distances
p records

def ways_to_beat record
  time, distance = record
  i = 1
  count = 0
  while i <= time/2
    v = i
    t = time - i
    d = v*t
    # p d
    if d > distance
      count += 1
    end

    i += 1
  end
  if time.odd?
    count = count*2
  else
    count = count*2 - 1
  end
  count
end

ways = records.map do |record|
  puts
  ways_to_beat record
end

p ways
p ways.reduce(:*)

