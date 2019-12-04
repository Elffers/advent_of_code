# Puzzle input
range = (272091..815432)

def has_double? n
  !n.to_s.match(/(.)\1{1,}/).nil?
end

def increases? n
  digits = n.to_s.chars.map { |x| x.to_i }
  current = digits.first
  while !digits.empty?
    d = digits.shift
    return false if d < current
    current = d
  end
  return true
end

count = range.select do |n|
  has_double?(n) && increases?(n)
end.count

p count
