require 'strscan'
require 'benchmark'

input = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day01.in").split("\n")

def part1 input
  x = input.map do |line|
    num = ""
    i = 0
    while !line.chars[i].match? /\d/
      i += 1
    end
    num += line.chars[i]
    i = line.length - 1
    while !line.chars[i].match? /\d/
      i -= 1
    end
    num += line.chars[i]
    num.to_i
  end
  x.sum
end

p "Part 1: #{part1 input}"

DIGITS = {
  "one" => 1,
  "two" => 2,
  "three" => 3,
  "four" => 4,
  "five" => 5,
  "six" => 6,
  "seven" => 7,
  "eight" => 8,
  "nine" => 9,
}

def part2 input
  x = input.map do |line|
    s = StringScanner.new(line)
    digits = []
    while !s.eos?
      if s.match?(/(one|two|three|four|five|six|seven|eight|nine|\d)/)
        digit = DIGITS.fetch(s.matched) { |el| el.to_i }
        digits << digit
      end
      s.getch
    end
    digits.first*10 + digits.last
  end
  x.sum
end
p "Part 2 #{part2 input}"

Benchmark.bm do |x|
  x.report { part1 input}
  x.report { part2 input}
end
