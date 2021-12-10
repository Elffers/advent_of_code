input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day06.in").split(",").map { |x| x.to_i }

# keeps track of how many fish there are with a particular internal clock value from 0-8 (corresponds to index)
counts = Hash.new 0
input.each do |x|
  counts[x] += 1
end

def tick counts
  nc = Hash.new 0
  counts.each do |k, v|
    if k == 0
      nc[6] += v
      nc[8] += v
    else
      nc[k-1] += v
    end
  end
  nc
end

256.times do |i|
  counts = tick counts
  if i == 79
    p "Part 1: #{counts.values.sum}"
  end
end
p "Part 2: #{counts.values.sum}"
