def checksum rows
  rows.map do |row|
    yield row
  end.reduce(:+)
end

def process input
  input.map do |row|
    row.split("\t").map { |x| x.strip.to_i }
  end
end

max_diff = Proc.new do |row|
  row.max - row.min
end

find_pair = Proc.new do |row|
  res = row.combination(2).select do |combo|
    combo.max % combo.min == 0
  end.first

  res.max / res.min
end

if $0 == __FILE__
  input = File.readlines('day2.in')
  rows = process input
  p "Part 1: #{checksum(rows, &max_diff)}"
  p "Part 1: #{checksum(rows, &find_pair)}"
end
