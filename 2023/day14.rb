input = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day14.in").split("\n")

def roll_north input
  width = input.first.size
  n = 0
  weight = 0
  height = input.size
  grid = []
  while n < width
    new_col = []
    col = input.map { |x| x[n]}
    score = height
    dots = 0
    col.each.with_index do |el, i|
      if el == "O"
        new_col << "O"
        weight += score
        score = score - 1
      elsif el == "."
        dots += 1
      elsif el == "#"
        dots.times { new_col << "." }
        dots = 0
        new_col << "#"
        score = height - (i+1)
      end
      if i == width-1
        dots.times { new_col << "."}
      end
    end
    grid << new_col
    n +=1
  end
  new_grid = []
  i = 0
  while i < grid.size
    new_grid << grid.map { |col| col[i]}
    i += 1
  end
  [weight, new_grid]
end

def roll_south input
  width = input.first.size
  n = 0
  weight = 0
  height = input.size
  grid = []
  while n < width
    new_col = []
    col = input.map { |x| x[n]}
    score = height
    rocks = 0
    col.each.with_index do |el, i|
      if el == "O"
        rocks += 1
        # weight += score
        # score = score - 1
      elsif el == "."
        new_col << "."
      elsif el == "#"
        rocks.times do |x|
          score = i+x
          weight += score
          new_col << "O"
        end
        rocks = 0
        new_col << "#"
        score = height - (i+1)
      end
      if i == width-1
        rocks.times { new_col << "O"}
      end
    end
    grid << new_col
    n += 1
  end

  new_grid = []
  i = 0
  while i < grid.size
    new_grid << grid.map { |col| col[i] }
    i += 1
  end
  [weight, new_grid]
end

def roll_west input
  out = []
  weight = 0
  height = input.size

  input.each.with_index do |row, i|
    new_row = []
    score = height-i
    dots = 0
    row.each.with_index do |char, j|
      if char == "O"
        new_row << "O"
        weight += score
      elsif char == "."
        dots += 1
      elsif char == "#"
        dots.times { new_row << "." }
        dots = 0
        new_row << "#"
      end
      if j == row.size-1
        dots.times { new_row << "." }
      end
    end
    out << new_row
  end
  [weight, out]
end

def roll_east input
  out = []
  weight = 0
  height = input.size
  input.each.with_index do |row, i|
    new_row = []
    score = height - i
    rocks = 0
    row.each.with_index do |char, j|
      if char == "O"
        rocks += 1
        #        weight += score
      elsif char == "."
        new_row << "."
      elsif char == "#"
        rocks.times { new_row << "O" }

        rocks = 0
        new_row << "#"
      end
      if j == row.size-1
        rocks.times { new_row << "O"}
      end
    end
    out << new_row
  end
  [weight, out]
end

def cycle input
  weight, input = roll_north input
  weight, input = roll_west input
  weight, input = roll_south input
  weight, input = roll_east input
end


  weight, input = roll_north(input)
  p weight

# 3.times do
#   weight, input = cycle(input)
#   p weight
# end

# input.each { |x| puts x.join }
