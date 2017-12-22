$grid = File.readlines("../day22.in").map { |x| x.strip }

# input = <<TEST
# ..#
# #..
# ...
# TEST
# $grid = input.split("\n").map { |x| x.strip }
# p $grid

n = $grid.size/2

$map = Hash.new { |h, k| h[k] = Hash.new "." }

$grid.each_with_index do |row, i|
  row.chars.each_with_index do |char, j|
    $map[i][j] = char
  end
end

$dirs = {
  up: [0, -1],
  down: [0, 1],
  left: [-1, 0],
  right: [1, 0]
}

def turn_left dir
  case dir
  when $dirs[:up]
    $dirs[:left]
  when $dirs[:down]
    $dirs[:right]
  when $dirs[:left]
    $dirs[:down]
  when $dirs[:right]
    $dirs[:up]
  end
end

def turn_right dir
  case dir
  when $dirs[:up]
    $dirs[:right]
  when $dirs[:down]
    $dirs[:left]
  when $dirs[:left]
    $dirs[:up]
  when $dirs[:right]
    $dirs[:down]
  end
end

def turn_back dir
  case dir
  when $dirs[:up]
    $dirs[:down]
  when $dirs[:down]
    $dirs[:up]
  when $dirs[:left]
    $dirs[:right]
  when $dirs[:right]
    $dirs[:left]
  end
end

def burst x, y, dir
  node = $map[x][y]

  if node == "#"
    dir = turn_right dir
    $map[x][y] = "."
  elsif node == "."
    dir = turn_left dir
    $map[x][y] = "#"
    $infections += 1
  end

  y += dir.first
  x += dir.last

  [x, y, dir]
end

$states = {
  "." => "W",
  "W" => "#",
  "#" => "F",
  "F" => ".",
}

def burst2 x, y, dir
  node = $map[x][y]

  if node == "#"
    dir = turn_right dir
  elsif node == "."
    dir = turn_left dir
  elsif node == "W"
    $infections += 1
  elsif node == "F"
    dir = turn_back dir
  end
  $map[x][y] = $states[node]

  y += dir.first
  x += dir.last

  [x, y, dir]
end

x, y = n, n
$infections = 0
dir = $dirs[:up]

# 10000.times do
#   x, y, dir = burst x, y, dir
#   # puts $grid.join "\n"
# end
# p $infections

10000000.times do
  x, y, dir = burst2 x, y, dir
end
p $infections
