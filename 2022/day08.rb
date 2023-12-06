input = File.read("/Users/hhhsu/sandbox/aoc/2022/inputs/day08.in").split("\n").map { |x| x.chars.map { |n| n.to_i } }

m = input.size
n = input.first.size
count = 0

input.each.with_index do |row, i|
  if i == 0 || i == m-1
    count += row.size
    next
  end

  row.each.with_index do |h, j|
    if j == 0 || j == n-1
      count += 1
      next
    end
    col = input.map { |r| r[j]}
    if row[0...j].all? { |n| n < h } ||
        row[j+1..-1].all? { |n| n < h } ||
        col[0...i].all? { |n| n < h } ||
        col[i+1..-1].all? { |n| n < h }
      count += 1
    end
  end
end
p "Part 1: #{count}"

score = 0

def trees_viewable_from h, trees
  count = 0
  trees.each do |t|
    if t >= h
      count += 1
      break
    end
    if t < h
      count += 1
    end
  end
  count
end

input.each.with_index do |row, i|
  next if i == 0 || i == m-1
  row.each.with_index do |h, j|
    next if j == 0 || j == n-1
    col = input.map { |r| r[j]}

    left = trees_viewable_from h, row[0...j].reverse
    right = trees_viewable_from h, row[j+1..-1]
    up = trees_viewable_from h, col[0...i].reverse
    down = trees_viewable_from h, col[i+1..-1]

    scenic_score = left*right*up*down
    score = scenic_score if scenic_score > score
  end
end

p "Part 2: #{score}"
