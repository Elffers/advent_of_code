require 'pp'

packets = File.read("/Users/hhhsu/sandbox/aoc/2022/inputs/day13.in").split("\n\n")
packets = File.read("/Users/hhhsu/sandbox/aoc/2022/inputs/day13test.in").split("\n\n")

# => bool
def ordered? l, r
    lcar = l.first
    l = l[1..-1]
    rcar = r.first
    r = r[1..-1]
  if lcar.is_a?(Integer) && rcar.is_a?(Integer)
    return true if lcar < rcar
    return false if lcar > rcar
  else
    ordered? l, r
  end
end

sum = 0
packets.each.with_index do |pair, i|
  l, r = pair.split("\n").map { |s| eval s }

  if ordered? l, r
    p "true"
    p l
    p r
    sum += i+1
  end
end

p "Part 1: #{sum}"
