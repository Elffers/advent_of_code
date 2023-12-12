input = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day11.in").split("\n")

empty_cols = []
cols = input.first.size
i = 0

while i < cols
  if !input.map { |row| row[i] }.include? "#"
    empty_cols << i
  end
  i += 1
end

empty_rows = []

input.each.with_index do |row, i|
  if !row.include? "#"
    empty_rows << i
  end
end

gals = []
input.each.with_index do |row, i|
  row.chars.each.with_index do |char, j|
    if char == "#"
      p = i
      q = j

      empty_rows.each do |x|
        p += 999_999 if x < i
      end

      empty_cols.each do |y|
        q += 999_999 if y < j
      end

      gals << [p, q]
    end
  end
end

sum = 0
gals.each do |(x, y)|
  gals.each do |(i, j)|
    dist = (x-i).abs + (y-j).abs
    sum += dist
  end
end
p sum/2

