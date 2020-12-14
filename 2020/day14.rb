input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day14.in").split("\n")

mem = Hash.new 0
mem2 = Hash.new 0

def mask_bits(bits, mask)
  ("%036b" % bits.to_i).chars.zip(mask.chars).map do |b, m|
    m == "X" ? b : m
  end.join.to_i(2)
end

# returns list of all masked addresses
def masked_addrs(addr, mask)
  floats = mask.count("X")

  bin = ("%036b" % addr.to_i).chars.zip(mask.chars).map do |b, m|
    m == "0" ? b : m
  end

  bit_combos = (0...2**floats).map do |float|
    ("%0#{floats}b" % float).chars
  end

  bit_combos.map do |combo|
    addr = bin.dup
    addr.map.with_index do |b, i|
      if b == "X"
        addr[i] = combo.shift
      else
        b
      end
    end.join.to_i(2)
  end
end

mask = "0" * 36
input.each do |x|
  instr, bits = x.split(" = ")
  if instr == "mask"
    mask = bits
  else
    /mem\[(?<addr>\d+)\]/ =~ instr

    # part 1
    mem[addr] = mask_bits(bits, mask)

    # part 2
    addrs = masked_addrs(addr, mask)
    addrs.each do |a|
      mem2[a] = bits.to_i
    end
  end
end

p "part 1: #{mem.values.sum}"
p "part 2: #{mem2.values.sum}"
