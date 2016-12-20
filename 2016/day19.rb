require 'pry'

def find_left i, elves
  left = (i + 1) % elves.size

  while elves[left] == 0
    left = (left + 1) % elves.size
  end

  left
end

def winner elves
  while elves.size != 1
    half = elves.size/2
    elves.delete elves[half]
    elves.rotate!
    # p elves
  end
  elves
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

# part 2

  # elves = (1..count).to_a
  # (1..730).each do |n|
  #   elves = (1..n).to_a
  #   p "#{n} #{winner elves}"
  # end

  n = 1
  # count = 600
  while 3 ** n <= count
    n+=1
  end
  n = n - 1
  power = 3 ** n
  remainder = count - power
  if remainder <power
    p remainder
  else
    p power + 2*(remainder - power)
  end

end
