input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day25test.in").split "\n"
# input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day25test2.in").split "\n"
# input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day25.in").split "\n"

def display input
  input.each do |x|
    puts x
  end
end

def step input
  h = input.size
  w = input.first.size

  res = Array.new(h)
  stopped = true

  # east herd first
  input.each_with_index do |row, x|
    # p "ROW: #{row}"
    new_row = Array.new(w, ".")
    row.chars.each_with_index do |sc, y|
      if sc == ">" 
        i = (y + 1) % w
        if  row[i] == "."
          new_row[i] = sc
          stopped = false
        else
          new_row[y] = sc
        end
      end
    end
    # p "NEW ROW: #{new_row}"
    res[x] = new_row.join
  end

  # res.each_with_index do |row, x|
  #   row.chars.each_with_index do |sc, y|
  #     i = (x + 1) % h
  #     if sc == "v" && res[x][i] == "."
  #       res[x][i] == sc
  #       stopped = false
  #     else
  #       res[x][y] == sc
  #     end
  #   end
  # end

  res
end


display input
puts
x = 2
x.times do
  input = step input
  display input
  puts
end
