input = File.readlines('day20.in')

ranges = input.map do |range|
  /(?<a>\d+)-(?<b>\d+)/ =~ range
  [a.to_i,  b.to_i]
end.sort

lowest = 0

ranges.each do |min, max|
  if (min..max).include?(lowest)
    lowest = max + 1
  end
end
p lowest

# part 2
count = 0
lowest  = 0
highest = 0

total = 4_294_967_295

ranges.each do |min, max|
  if min > highest + 1
    lowest = min
    whitelisted = lowest - highest - 1
    count += whitelisted
  end

  highest = max if max > highest
  # p [lowest, highest, count]
end

count += total - highest

p count
