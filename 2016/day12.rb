require 'pry'

class Assembler
  attr_accessor :registers

  def initialize
    @registers = Hash.new 0
  end

  def parse input
    i = 0

    while i < input.size
      line = input[i]
      parts = line.split(' ')

      if line['cpy']
        copy parts
        i += 1
      end

      if line['inc']
        increment parts
        i += 1
      end

      if line['dec']
        decrement parts
        i += 1
      end

      if line['jnz']
        offset = jump parts
        i += offset
      end
    end
  end

  def copy parts
    val = parts[1]
    reg = parts[2]
    if /\d+/ =~ val
      val = val.to_i
    else
      val = registers[val]
    end

    registers[reg] = val
  end

  def increment parts
    reg = parts[1]
    registers[reg] += 1
  end

  def decrement parts
    reg = parts[1]
    registers[reg] -= 1
  end

  def jump parts
    reg = parts[1]
    offset = parts[2]

    if !zero? reg
      return offset.to_i
    else
      return 1
    end
  end

  def zero? reg
    if /\d+/ =~ reg
      return reg.to_i == 0
    else
      return registers[reg] == 0
    end
  end
end

if __FILE__ == $0
  input = File.read('day12.in').split("\n")
  a = Assembler.new
  a.parse input
  p a.registers
end
