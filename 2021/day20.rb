require 'pp'
input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day20test.in").split("\n\n")
# input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day20.in").split("\n\n")

@algo, i = input

img = Array.new { Hash.new { |h,k| h[k] = "." } }

i.split("\n").each_with_index do |row, i|
  row.chars.each_with_index do |px, j|
    img[i][j] = px
  end
  img
end
p img

def px_val x, y, img
  min = img.keys.min
  max = img.keys.max
  i = [
    [-1, -1], [-1, 0], [-1, 1],
    [ 0, -1], [ 0, 0], [ 0, 1],
    [ 1, -1], [ 1, 0], [ 1, 1],
  ].map do |(i,j)|
    dx, dy = x+i, y+j
    if (min <= dx && dx <= max) && (min <= dy && dy <= max)
      img[dx][dy]
    else
      "."
    end
  end.map do |c|
    c == "." ? 0 : 1
  end.join
  p i
  i = i.to_i(2)
  p @algo[i]
  puts

  @algo[i]
end

def enhance img
  count = 0
  min = img.keys.min
  max = img.keys.max

  new_img = Hash.new

  (min-1..max+1).each do |k|
    new_img[k] = Hash.new
  end

  (min-1..max+1).each do |v|
    new_img[v][v] = "."
  end

  img[min-1] = Hash.new
  img[max+1] = Hash.new
  (min-1..max+1).each do |v|
    img[min-1][v] = "."
    img[max+1][v] = "."
  end

  img.each_pair do |k, v|
    v[min-1] = "."
    v[max+1] = "."
  end

  img.sort_by { |k, v| k }.each do |x, val|
    val.sort_by { |k, v| k }.each do |y, _|
      px = px_val x, y, img
      new_img[x][y] = px
      count += 1 if px == "#"
    end
  end
  # pp new_img
  # TODO need to also calculate edges
  # new_img[min-1] = new_row
  # new_img[max+1] = new_row

  [new_img, count]
end

def display img
  img.sort_by { |k, v| k}.each do |k, v|
    row = ""
    v.sort_by { |k, v| k }.each do |i, px|
      row += px
    end
    puts row
  end
end

# p "PIXEL #{px_val 0, 0, img}"
# display img
puts

# img, count = enhance img
# display img
# p count
# puts

# # img, count = enhance img
# # display img
# # p "Part 1: #{count}"
