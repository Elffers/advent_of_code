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

p "Part 1: #{ways.reduce(:*)}"
p "Part 2: #{ways_to_beat record2}"

