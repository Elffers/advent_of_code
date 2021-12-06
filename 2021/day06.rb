input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day06test.in").split(",").map { |x| x.to_i }
# input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day06.in").split(",").map { |x| x.to_i }

def tick input
  out = Array.new(input.size + input.count(0))
  ni = input.size
  input.each_with_index do |x,i|
    if x == 0
      out[i] = 6
      out[ni] = 8
      ni += 1
    else
      out[i] = x-1
    end
  end
  out
end

x = [4] 
30.times do |i|
  x = tick x
  p [i+1, x.length]
end
p "Part 1: #{x.length}"

# x = input
# 256.times do |i|
#   p [i, x.length]
#   x = tick x
# end

# p x.length
# def spawn clock, days
#   if days = 0
#     return 1
#   end
# end
