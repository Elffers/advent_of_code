require 'strscan'

rows = File.read("/Users/hhhsu/sandbox/aoc/2023/inputs/day03.in").split("\n")
rows = File.read("/Users/hhhsu/sandbox/aoc/2023/inputs/day03_test.in").split("\n")

rows.each do |row|
  s = StringScanner.new(row)
  while !s.eos?
    if s.match?(/\d+/)
    end
  end
end

def adjacent schematic, x, y
end
