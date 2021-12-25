input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day25.in").split "\n"

def display input
  input.each do |x|
    puts x
  end
end

def move_east input
  h = input.size
  w = input.first.size

  east = Array.new(h)
  stopped = true

  input.each_with_index do |row, x|
    new_row = Array.new(w, ".")
    row.chars.each_with_index do |sc, y|
      if sc == "v"
        new_row[y] = sc
      end
      if sc == ">"
        i = (y + 1) % w
        if row[i] == "."
          new_row[i] = sc
          stopped = false
        else
          new_row[y] = sc
        end
      end
    end
    east[x] = new_row.join
  end

  [east, stopped]
end

def move_south input, stopped
  input = input.map { |x| x.chars }.transpose
  h = input.size
  w = input.first.size

  south = Array.new(h)

  # south herd
  input.each_with_index do |row, x|
    new_row = Array.new(w, ".")
    row.each_with_index do |sc, y|
      if sc == ">"
        new_row[y] = sc
      end
      if sc == "v"
        i = (y + 1) % w
        if row[i] == "."
          new_row[i] = sc
          stopped = false
        else
          new_row[y] = sc
        end
      end
    end
    south[x] = new_row
  end
  south = south.transpose.map { |x| x.join }

  [south, stopped]
end

def step input
  x, s = move_east input
  move_south x, s
end

count = 0
loop do
  input, x = step input
  count += 1
  if x
    break
  end
end
p count
