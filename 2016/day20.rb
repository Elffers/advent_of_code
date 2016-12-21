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
