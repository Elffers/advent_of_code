require_relative 'day12.rb'

class Assembler2 < Assembler

  def initialize
    super
    registers['a'] = 7
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
      when 'tgl'
        index = registers[x] + i
        unless index >= input.size
          old_instr = input[index]
          new_instr = toggle old_instr
          input[index] = new_instr
        end
        i += 1

      end
    end
  end

  def toggle instr
    instr, x, y = instr.split(' ')
    if y
      instr = instr == 'jnz' ? 'cpy' : 'jnz'
    else
      instr = instr == 'inc' ? 'dec' : 'inc'
    end

    [instr, x, y].join(' ')
  end
end

input = File.read('day23.in').split("\n")

test = StringIO.new(<<INPUT
cpy 2 a
tgl a
tgl a
tgl a
cpy 1 a
dec a
dec a
INPUT
                   ).readlines.map { |x| x.strip }
a = Assembler2.new
a.parse input
p a.registers
