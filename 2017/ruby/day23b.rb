# require 'prime'

b = 107900
c = 124900

d = f = h = 0
loop do
  f = true # Indicates if b is prime

  # d and e represents potential factors of b
  d = 2

  while d < b
    if b % d == 0
      f = false
      break
    end
    d += 1
  end

  # H is count of number of non-primes between b and c by intervals of 17
  if !f
    # p b, h
    h += 1
  end

  if b == c
    break
  end
  b += 17
end
p h

# count = 0
# (b..c).step(17) do |p|
#   count +=1 if !p.prime?
# end
# p count

