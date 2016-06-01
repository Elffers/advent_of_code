require 'pry'
class Assembler
  attr_accessor :instructions, :registers

  def initialize input
    @instructions = input.map { |line| line.strip! }
    @registers = { "a" => 1, "b" => 0 }
  end

  def parse
    i = 0
    while i < instructions.length
      line = instructions[i]
      /(?<instr>\w{3}) (?<reg_or_inc>\w|.\d+)(,?)(?<inc>.*)/ =~ line

      case instr
      when 'inc'
        registers[reg_or_inc] += 1
        i += 1
      when 'hlf'
        registers[reg_or_inc] *= 0.5
        i += 1
      when 'tpl'
        registers[reg_or_inc] *= 3
        i += 1
      when 'jmp'
        i += reg_or_inc.to_i
      when 'jio'
        if registers[reg_or_inc] == 1
          i += inc.to_i
        else
          i += 1
        end
      when 'jie'
        if registers[reg_or_inc].to_i.even?
          i += inc.to_i
        else
          i += 1
        end
      end
    end
  end
end

if __FILE__ == $0
  input = File.readlines("day23_input.txt")
  a = Assembler.new input
  a.parse
  p a.registers
end
