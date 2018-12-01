input = File.readlines("day01.in").map { |x| x.strip.to_i }
p input.reduce(:+)
