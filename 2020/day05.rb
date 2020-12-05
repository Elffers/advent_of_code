require 'pp'
input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day05.in").map { |x| x.strip }

# map each line to binary representation
seats = input.map do |x|
  row = x[0,7].tr("FB", "01")
  col =  x[7,10].tr("LR", "01")
  row + col
end

# binary rep already is the same thing as multiplying row by 8 and adding column,
# since we're shifting the first 7 bits left by 3 bits
id = seats.max
p "part 1: #{id.to_i(2)}"

sorted = seats.map do |b|
  b.to_i(2)
end.sort

offset = sorted.first

# to find missing seat, find which of the sorted list does not correspond to
# index plus offset of first seat
sorted.each_with_index do |s, i|
  if s != i + offset
    p "part 2: #{s - 1}"
    break
  end
  i += 1
end
