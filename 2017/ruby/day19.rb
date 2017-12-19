input = File.read("../day19.in").split "\n"

x, y = 0, 1
dir = [1, 0]
letters = []

vert = [
  [-1, 0], [1, 0]
]

horiz = [
  [0, 1], [0, -1]
]

steps = 0
while !dir.nil?
  steps += 1
  x += dir.first
  y += dir.last
  char = input[x][y]

  if char =~ /\w/
    letters << char
  end
  if char == " "
    p letters: letters.join, steps: steps
    exit
  end

  until char == "+"
    steps += 1
    x += dir.first
    y += dir.last
    char = input[x][y]
    if char == " "
      p letters: letters.join, steps: steps
      exit
    end

    if char =~ /\w/
      letters << char
    end
  end

  turns = dir.first == 0 ? vert : horiz
  dir = turns.find do |i, j|
    i += x
    j += y
    if i > 0 && j > 0 && i < input.size && j < input[i].size
      input[i][j].strip != ""
    end
  end
end

p letters: letters.join, steps: steps
