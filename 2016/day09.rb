require 'strscan'
require 'pry'

def decompressed_length input
  s = StringScanner.new input

  length = 0
  tail_index = 0

  while !s.eos?
    if s.exist?(/\(\d+x\d+\)/)
      s.scan_until(/\(\d+x\d+\)/)
      prematch_length = s.pos - s.matched_size - tail_index

      # count all characters up to marker
      length += prematch_length

      chars, iter = s.matched.delete("()").split('x').map(&:to_i)

      # add length of decompressed sequence
      s.pos += chars
      length += chars * iter

      # move tail up to current position
      tail_index = s.pos
    else
      length += 1
      s.pos += 1
    end
  end
  length
end

# part 2

def recursive_decompress str
  # null case
  if str.length == 0
    return str.length
  end
  if match_index = (/\((?<chars>\d+)x(?<iter>\d+)\)/ =~ str)
    start_index = match_index + $&.length
    stop_index = start_index + chars.to_i
    compressed = str[start_index...stop_index]
    cdr = str[stop_index..-1]
    decompressed_length = iter.to_i * recursive_decompress(compressed)
    match_index + decompressed_length + recursive_decompress(cdr)
  else
    return str.length
  end
end

if __FILE__ == $0
  # input = "ADVENT"
  # input = "A(1x5)BC"
  # input = "A(1x5)BC"
  # input = "(3x3)XYZ"
  # input = "A(2x2)BCD(2x2)EFG" #11
  # input = "(6x1)(1x3)A" #6
  # input = "X(8x2)(3x3)ABCY"
  input = File.read('day9.in').strip
  p decompressed_length input #112830
  p recursive_decompress input
end

