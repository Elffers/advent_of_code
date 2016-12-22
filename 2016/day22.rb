input = File.readlines('day22.in')
# 35 * 25
2.times do
  input.shift
end

# use regular map to preserve columns and rows
grid = input.each_slice(25).flat_map do |row|
  row.map do |line|
    path, size, used, avail, perc = line.split
    [size, used, avail].map(&:to_i)
  end
end

count = 0
grid.each do |node|
  unless node[1] == 0
    count += grid.count { |x| x[2] > node[1] }
  end
end

p count

