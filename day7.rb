class AND
  attr_accessor :a, :b, :out

  def initialize(a, b, out)
    @a = a
    @b = b
    @out = out
  end
end

class OR
  attr_accessor :a, :b, :out

  def initialize(a, b, out)
    @a = a
    @b = b
    @out = out
  end
end

class LSHIFT
  attr_accessor :a, :bits, :out

  def initialize(a, bits, out)
    @a = a
    @bits = bits
    @out = out
  end
end

class RSHIFT
  attr_accessor :a, :bits, :out

  def initialize(a, bits, out)
    @a = a
    @bits = bits
    @out = out
  end
end

class NOT
  attr_accessor :in, :out

  def initialize(inn, out)
    @in = inn
    @out = out
  end
end

class Circuit
  attr_accessor :wires

  def initialize
    @wires = {}
  end

  def build(instructions)
    instructions.each_line do |instr|
      parse instr
    end
  end

  def parse(instruction)
    left, out = instruction.split("->").map { |x| x.strip }
    signal =
      if /^(?<signal>\d+)/ =~ left
        signal.to_i
      elsif /(?<a>\w+) AND (?<b>\w+)/ =~ left
        wires[a] & wires[b]
      elsif /(?<a>\w+) OR (?<b>\w+)/ =~ left
        wires[a] | wires[b]
      elsif /(?<a>\w+) LSHIFT (?<bits>\w+)/ =~ left
        wires[a] << bits.to_i
      elsif /(?<a>\w+) RSHIFT (?<bits>\w+)/ =~ left
        wires[a] >> bits.to_i
      elsif /^NOT (?<a>\w+)/ =~ left
        [~wires[a]].pack("s").unpack("S").first
      end
     wires[out] = signal
  end
end

if $0 == __FILE__
  instructions = File.read("day7_input.txt")
  circuit = Circuit.new
  circuit.build(instructions)
  p circuit.wires
end

