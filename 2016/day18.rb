def trap? index, row
  left_index = index - 1
  right_index = index + 1

  l =  left_index < 0 ? 1 : row[left_index]
  r =  right_index > row.length - 1 ? 1 : row[right_index]

  l != r ? 0 : 1
end

def next_row row
  row.map.with_index do |el, i|
    trap? i, row
  end
end

def count_safe row, total
  count = row.reduce(:+)
  i = 1
  while i < total
    row = next_row row
    count += row.reduce(:+)
    i += 1
  end

  count
end

def preprocess row
  row.chars.map do |el|
    el == '^' ? 0 : 1
  end
end

if __FILE__ == $0
  row = '^^^^......^...^..^....^^^.^^^.^.^^^^^^..^...^^...^^^.^^....^..^^^.^.^^...^.^...^^.^^^.^^^^.^^.^..^.^'
  row = preprocess row
  p count_safe row, 40000
end
