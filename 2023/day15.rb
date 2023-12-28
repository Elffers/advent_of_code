input = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day15.in").chomp.split(",")

# Determine the ASCII code for the current character of the string.
# Increase the current value by the ASCII code you just determined.
# Set the current value to itself multiplied by 17.
# Set the current value to the remainder of dividing itself by 256.

def find_hash string
  curr = 0
  string.chars.each do |char|
    curr += char.ord
    curr *= 17
    curr = curr % 256
  end
  curr
end

def find_hashmap str
  if str.chars.last == "-"
    str = str.chop
  end
  if str.include? "="
    str, box = str.split "="
  end
  [str, find_hash(str), box]
end

sum = 0

hashmap = Hash.new { |h, k| h[k] = {} }

input.each do |str|
  x = find_hash str
  label, box, val = find_hashmap str
  if !val.nil?
    hashmap[box][label] = val
  else
    hashmap[box].delete label
  end
  sum += x
end

p "Part 1: #{sum}"

sum = 0
hashmap.each do |box, lenses|
  lenses.each.with_index do |lens, i|
    pwr = (box+1) * (i+1) * lens.last.to_i
    sum += pwr
  end
end
p "part 2: #{sum}"
