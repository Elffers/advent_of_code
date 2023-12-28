input = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day15.in").chomp.split(",")
p input

# Determine the ASCII code for the current character of the string.
# Increase the current value by the ASCII code you just determined.
# Set the current value to itself multiplied by 17.
# Set the current value to the remainder of dividing itself by 256.

def foo string
  curr = 0
  string.chars.each do |char|
    curr += char.ord
    curr *= 17
    curr = curr % 256
  end
  curr
end

sum = 0

input.each do |str|
  x = foo str
  p x
  sum += x
end
p sum
