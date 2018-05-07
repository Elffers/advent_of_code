d = e = f = g = h = 0

# b = 79        # set b 79
# c = b         # set c b
# b = b*100     # mul b 100
# b += 100_000  # sub b -100000
# c = b         # set c b
# c += 17_000   # sub c -17000

b = 107900
c = 124900

loop do
  f = true          # set f 1
  d = 2             # set d 2

  while g != 0
    e = 2           # set e 2
    while g != 0
      g = d         # set g d
      g *= e        # mul g e
      g -= b        # sub g b
      if g == 0     # jnz g 2
        f = false   # set f 0
      end
      e -= 1        # sub e -1
      g = e         # set g e
      g -= b        # sub g b
    end             # jnz g -8
    d -= 1          # sub d -1
    g = d           # set g d
    g -= b          # sub g b
  end               # jnz g -13

  if !f             # jnz f 2
    h += 1          # sub h -1
  end

  g = b             # set g b
  g -= c            # sub g c
  if g == 0         # jnz g 2
    break           # jnz 1 3
  end
  b += 17           # sub b -17
end                 # jnz 1 -23
p h
