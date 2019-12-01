input = File.readlines("./inputs/day01.in").map { |x| x.strip.to_i }

def fuel_for mass
  mass/3 - 2
end

sum = input.map { |x| fuel_for x}.reduce(:+)
p "Part 1: #{sum}"

def find_fuel mass
  mass = fuel_for mass
  total = 0
  while mass > 0
    total += mass
    mass = fuel_for mass
  end

  total
end

total = input.map do |x|
  find_fuel(x)
end.reduce(:+)

p "Part 2: #{total}"

# "Part 1: 3252897"
# "Part 2: 4876469"
