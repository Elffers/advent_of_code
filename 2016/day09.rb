require 'strscan'

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
    # Find start and stop index of compressed substring
    start_index = match_index + $&.length
    stop_index = start_index + chars.to_i
    compressed = str[start_index...stop_index]

    # Save remaining substring not included by marker
    cdr = str[stop_index..-1]

    # Recursively decompress everything covered by marker
    decompressed_length = iter.to_i * recursive_decompress(compressed)

    # match_index is the same as length of substring preceding matched marker
    match_index + decompressed_length + recursive_decompress(cdr)
  else
    return str.length
  end
end

if __FILE__ == $0
  input = File.read('day9.in').strip
  p decompressed_length input
  p recursive_decompress input
end

