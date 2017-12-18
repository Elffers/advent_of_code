col = 3029
row = 2947

   # 1  2  3  4   5
# 1| 1  3  6  10  15
# 2| 2  5  9  14
# 3| 4  8  13
# 4| 7  12
# 5| 11

y = 0
i = 1

while i <= col
  y += i
  i += 1
end

# p col_start: y

x = y
j = col

(row - 1).times do
  x += j
  j += 1
end

# p nth: x

code = 20151125
(x - 1).times do
  code = (code * 252533) % 33554393
end
p code
