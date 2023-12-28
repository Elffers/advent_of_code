input = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day12.in").split("\n")
input = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day12_test.in").split("\n")

def combos data, keys
  springs = data.split(".")
end

input.each do |line|
  data, key = line.split
  key = key.split(",").map { |x| x.to_i }
end

def matches key, input
  #.#.###
  # 1, 1, 3

  combo = input.chars
  curr_count = key.shift
  while curr_count
    char = combo.shift

    while char
      if char == "#"
        curr_count -= 1
      end

      if curr_count < 0
        return false
      end

      peek = combo.first
      if (curr_count == 0) && (peek == ".")
        curr_count = key.shift
      end

      char = combo.shift

      if (curr_count == 0) && key.empty? && combo.empty?
        return true
      end
    end

  end

  return false if !combo.empty?

  true
end

p matches [1, 1, 3], "#.##.###"
