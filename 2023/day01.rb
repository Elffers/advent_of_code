require 'strscan'

input = File.read("/Users/hhhsu/sandbox/aoc/2023/inputs/day01.in").split("\n")

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

p "Part 1: #{x.sum}"

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
p "Part 2 #{x.sum}"
