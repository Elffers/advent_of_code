def sum input
  digits = input.strip.chars.map { |x| x.to_i }
  sum = 0

  # Account for list of digits being circular
  sum += digits.first if (digits.last == digits.first)

  current = digits.shift

  while !current.nil?
    sum += current if current == digits.first
    current = digits.shift
  end

  sum
end

def half_sum input
  digits = input.strip.chars.map { |x| x.to_i }
  offset = digits.size/2
  sum = 0
  digits.each_with_index do |d, i|
    if d == digits[i + offset]
      sum += 2*d
    end
  end
  sum
end

if $0 == __FILE__
  input = File.read('day01.in')
  p sum input
  p half_sum input
end

