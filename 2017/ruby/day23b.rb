d = e = f = h = 0

b = 107900
c = 124900

loop do
  f = true
  d = 2

  while d != b
    e = 2
    while e != b
      if d * e == b
        f = false
      end
      e += 1
    end

    d += 1
  end

  if !f
    h += 1
  end

  if b == c
    break
  end
  b += 17
end
p h
