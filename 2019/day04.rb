# Puzzle input
range = (272091..815432)

def has_double? n
  !n.to_s.match(/(.)\1{1,}/).nil?
end

def valid? n
  count = Hash.new 0
  digits = n.to_s.chars.map { |x| x.to_i }
  current = digits.first

  while !digits.empty?
    d = digits.shift
    return false if d < current
    count[d] += 1
    current = d
  end
  count.values.include? 2
end

pwds = range.select do |n|
  valid?(n)
end

p pwds.count
