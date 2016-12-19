require 'pry'

def find_left i, elves
  left = (i + 1) % elves.size

  while elves[left] == 0
    left = (left + 1) % elves.size
  end

  left
end

if __FILE__ == $0
  count = 3001330
  # elves = count.times.map { 1 }

  # elves.cycle.with_index do |elf, i|
  #   index = i % count
  #   next if elf == 0

  #   left_index = find_left index, elves

  #   elves[index] += elves[left_index]
  #   elves[left_index] = 0
  #   p elves

  #   abort "size:#{count}, elf: #{index + 1}" if elves.any? { |x| x == count }
  # end

  n = 1
  while 2** n <= count
    n += 1
  end
  power = 2 ** (n - 1)
  remainder = count - power
  p remainder * 2 + 1
end
