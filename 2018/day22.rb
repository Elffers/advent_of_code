
START = [0,0]
TARGET = [14, 778]
DEPTH = 11541
EROSION_LEVELS = Hash.new { |h,k| h[k] = Hash.new }

def geo_index x, y
  if [x,y] ==  START || [x, y] == TARGET
    return 0
  end
  if y == 0
    return x * 16807
  end
  if x == 0
    return y * 48271
  end

  EROSION_LEVELS[x-1][y] * EROSION_LEVELS[x][y-1]
end

tx, ty = TARGET

risk = 0

(0..ty).each do |y|
  (0..tx).each do |x|
    i = geo_index x, y
    el = (i + DEPTH) % 20183
    EROSION_LEVELS[x][y] = el
    risk += (el % 3)
  end
end

p "Part 1: #{risk}"
