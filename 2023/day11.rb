input = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day11.in").split("\n")
# input = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day11_test.in").split("\n")
expanded = []


empty_cols = []
input.each.with_index do |row, i|
  if !input.map { |row| row[i] }.include? "#"
    empty_cols << i
  end
end

expanded = []

gals = []
input.each.with_index do |row, i|
  expanded_row = ""
  row.chars.each.with_index do |char, j|
      expanded_row << char
    if empty_cols.include? j
      expanded_row << char
    end
  end
  expanded << expanded_row

  if !expanded_row.include? "#"
    expanded << expanded_row
  end
end

expanded.each.with_index do |row, i|
  row.chars.each.with_index do |char, j|
    if char == "#"
      gals << [i, j]
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



