input = File.readlines("day01.in").map { |x| x.strip.to_i }
# part 1
p input.reduce(:+)

# part 2
current  = 0
frequencies = { current => true }
loop do
  input.each do |x|
    current = current + x
    if frequencies[current]
      p "FOUND: #{current}"
      exit
    else
      frequencies[current] = true
    end
  end
end
