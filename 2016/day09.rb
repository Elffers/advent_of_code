require 'strscan'

input = File.read('day9.in').strip
#
# input = "ADVENT"
# input = "A(1x5)BC"
# input = "A(1x5)BC"
# input = "(3x3)XYZ"
# input = "A(2x2)BCD(2x2)EFG" #11
# input = "(6x1)(1x3)A" #6
# input = "X(8x2)(3x3)ABCY"

s = StringScanner.new input

length = 0
tail_index = 0

while !s.eos?
  if s.exist?(/\(\d+x\d+\)/)
    s.scan_until(/\(\d+x\d+\)/)
    p "position after match: #{s.pos}"

    prematch_length = s.pos - s.matched_size - tail_index

    p "num chars before: #{prematch_length}"

    length += prematch_length

    chars, iter = s.matched.delete("(").delete(")").split('x').map(&:to_i)
    p [chars, iter]
    s.pos += chars
    length += chars * iter
    p "length: #{length}"
    p "next char: #{input[s.pos]}"
    tail_index = s.pos
    p "---------------"

  else
    length += 1
    s.pos += 1
  end
end

p "length: #{length}"
