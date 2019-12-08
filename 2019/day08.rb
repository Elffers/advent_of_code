pwd = File.read("./inputs/day08.in").strip
ROWS = 6
COLS = 25

dim = ROWS*COLS

counts = {}
layers = []

pwd.chars.each_slice(dim) do |layer|
  count = layer.count("0")
  counts[count] = layer
  layers << layer
end

min = counts.keys.min
p "Part 1: #{counts[min].count("1")* counts[min].count("2")}"
# 2904

def print_layer layer
  layer.each_slice(COLS) do |row|
    x = row.map {|i| i == "0" ? " " : "*" }
    puts x.join
  end
end

# Part 2
out = (0...dim).map do |i|
  n = 0
  pxl = layers[n][i]
  while pxl == "2"
    n += 1
    pxl = layers[n][i]
  end
  pxl
end

print_layer out
# HGBCF
