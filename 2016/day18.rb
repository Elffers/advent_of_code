def trap? index, previous_row
  l = previous_row[index - 1]
  r = previous_row[index + 1]

  l == '^' && r == '.' ||
    r == '^' && l == '.'
end

def next_row row
  padded_row = "." + row + "."
  row.chars.map.with_index do |el, i|
    if trap? i + 1, padded_row
      '^'
    else
      '.'
    end
  end.join
end

def count_safe row, total
  count = row.count('.')
  i = 1
  while i < total
    row = next_row row
    count += row.count '.'
    i += 1
  end
  count
end

if __FILE__ == $0
  row = '^^^^......^...^..^....^^^.^^^.^.^^^^^^..^...^^...^^^.^^....^..^^^.^.^^...^.^...^^.^^^.^^^^.^^.^..^.^'
  p count_safe row, 400000
end
