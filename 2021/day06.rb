input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day06.in").split(",").map { |x| x.to_i }
# input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day06test.in").split(",").map { |x| x.to_i }
p input
p input.length

def tick input
  out = []
  new = []
  input.each do |x|
    if x == 0
      out << 6
      new << 8
    else
      out << x-1
    end
  end
  out + new
  # new = []
  # old.each do |x|
  #   if x == 6
  #     new << 8
  #   end
  # end

  # old.concat new
end

x = input
80.times do
  x = tick x
end

p x.length
