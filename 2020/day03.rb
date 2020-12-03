# input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day03test.in").map { |x| x.strip }
input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day03.in").map { |x| x.strip }

x1 = 0
t1 = 0 # right 3, down 1

x2 = 0
t2 = 0 # Right 1, down 1.

x3 = 0
t3 = 0 # Right 5, down 1.

x4 = 0
t4 = 0 # Right 7, down 1.

x5 = 0
t5 = 0 # Right 1, down 2.

input.each_with_index do |row, j|
  if j == 0
    next
  end

  x1 += 3
  i1 = x1 % row.length
  t1+= 1 if row[i1] == "#"

  x2 += 1
  i2 = x2 % row.length
  t2+= 1 if row[i2] == "#"

  x3 += 5
  i3 = x3 % row.length
  t3+= 1 if row[i3] == "#"

  x4 += 7
  i4 = x4 % row.length
  t4+= 1 if row[i4] == "#"

  if j % 2 == 0
    x5 += 1
    i5 = x5 % row.length
    t5+= 1 if row[i5] == "#"
  end

end

p "part 1: #{t1}"
p "part 2: #{t1* t2* t3* t4 * t5}"

