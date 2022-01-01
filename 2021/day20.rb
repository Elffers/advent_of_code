require 'pp'
input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day20test.in").split("\n\n")
input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day20.in").split("\n\n")

algo, x = input
@algo = algo.split("\n").join

img = Hash.new

x.split("\n").each_with_index do |row, i|
  obj = Hash.new
  row.chars.each_with_index do |px, j|
    obj[j] = px
    img[i] = obj
  end
  img
end

def px_val2 x, y, img, on
  min = img.keys.min
  max = img.keys.max

  adj = [
    [-1, -1], [-1, 0], [-1, 1],
    [ 0, -1], [ 0, 0], [ 0, 1],
    [ 1, -1], [ 1, 0], [ 1, 1],
  ].map do |(i,j)|
    [x+i, y+j]
  end

  b = adj.map do |(dx, dy)|
    if (min <= dx && dx <= max) && (min <= dy && dy <= max)
      img[dx][dy]
    else
      "#"
      # if on
      #   "."
      # else
      #   "#"
      # end
    end
  end.map do |c|
    c == "." ? 0 : 1
  end.join

  i = b.to_i(2)
  @algo[i]
end
def px_val x, y, img, on
  min = img.keys.min
  max = img.keys.max

  adj = [
    [-1, -1], [-1, 0], [-1, 1],
    [ 0, -1], [ 0, 0], [ 0, 1],
    [ 1, -1], [ 1, 0], [ 1, 1],
  ].map do |(i,j)|
    [x+i, y+j]
  end

  b = adj.map do |(dx, dy)|
    if (min <= dx && dx <= max) && (min <= dy && dy <= max)
      img[dx][dy]
    else
      "."
      # if on
      #   "."
      # else
      #   "#"
      # end
    end
  end.map do |c|
    c == "." ? 0 : 1
  end.join

  i = b.to_i(2)
  @algo[i]
end

def enhance img, on
  count = 0
  min = img.keys.min
  max = img.keys.max

  new_img = Hash.new

  (min-1..max+1).each do |i|
    new_img[i] = Hash.new
    (min-1..max+1).each do |j|
      px = if !on
      px_val i, j, img, on
      else
       px_val2 i, j, img, on
      end
      count += 1 if px == "#"
      new_img[i][j] = px
    end
  end

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

25.times do
  img, count = enhance img, false
  # display img
  p count
  img, count = enhance img, true
  # display img
  p count
end
