require 'pry'
class Assembler
  attr_accessor :registers

  def initialize
    @registers = {"a"=>0, "b"=>0, "d"=>0, "c"=>0}
  end

  def parse input
    i = 0

    while i < input.size
      line = input[i]
      instr, x, y = line.split(' ')

      case instr
      when 'cpy'
        copy x, y
        i += 1
      when 'inc'
        registers[x] += 1
        i += 1
      when 'dec'
        registers[x] -= 1
        i += 1
      when 'jnz'
        offset = jump x, y
        i += offset
      end
    end
  end

  def copy val, reg
    if value = registers[val]
      registers[reg] = value
    else
      registers[reg] = val.to_i
    end
  end

  def jump reg, offset
    reg = /\w/ =~ reg ? registers[reg] : reg
    offset = /-?\d/ =~ offset ? offset.to_i : registers[offset]
    if reg != 0
      offset
    else
      1
    end
  end

end

if __FILE__ == $0
  input = File.read('day12.in').split("\n")
  a = Assembler.new
  a.parse input
  p a.registers
end
