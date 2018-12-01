input = File.readlines("inputs/day1.in").map { |x| x.strip.to_i }
p "Part 1: #{input.reduce(:+)}"

current  = 0
frequencies = { current => true }
input.cycle do |delta|
  current += delta
  if frequencies.include? current
    p "Part 2: #{current}"
    break
  else
    frequencies[current] = true
  end
end
