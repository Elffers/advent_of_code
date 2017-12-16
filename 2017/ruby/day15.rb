a = 591
b = 393
# a = 65
# b = 8921

a_factor = 16807
b_factor = 48271
divisor = 2147483647
f = "ffff".hex # 65535 == 2**16 - 1 == 16 1s in binary

count = 0

40_000_000.times do
  a = a*a_factor % divisor
  b = b*b_factor % divisor
  if a & f == b & f
    count += 1
  end
end

p "Part 1: #{count}"

# Part 2

def find_pair a, b
  a_factor = 16807
  b_factor = 48271
  divisor = 2147483647

  a = a*a_factor % divisor
  b = b*b_factor % divisor

  while a % 4 != 0
    a = a*a_factor % divisor
  end

  while b % 8 != 0
    b = b*b_factor % divisor
  end
  [a, b]
end

a = 591
b = 393
count = 0

5_000_000.times do
  a, b = find_pair a, b
  if a & f == b & f
    count += 1
  end
end

p "Part 2: #{count}"
