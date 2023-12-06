input = File.read("/Users/hhhsu/sandbox/aoc/2022/inputs/day06.in").strip

def find_marker(input, marker_length)
  buf = []
  input.chars.each.with_index do |char, i|
    if buf.length == marker_length
      buf.shift
    end
    buf << char
    if buf.uniq.length == marker_length
      return i + 1
    end
  end
end

p "Part 1: #{find_marker input, 4}"
p "Part 2: #{find_marker input, 14}"
