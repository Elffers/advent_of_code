class Computer
  attr_accessor :memory, :device, :output

  def initialize memory, device
    @memory = memory
    @device = device # IO device. Currently only expecting one A/C, but maybe extensible
  end

  def run
    ip = 0
    jump = 0

    while @memory[ip] != 99
      # Initialize instruction
      # NOTE: Pad this with two 0's only, since this is only needed for opcode 1
      # and 2 where the 3rd parameter is always one that is written to so
      # therefore always has param mode 0
      instr = sprintf("%04d", @memory[ip])
      opcode = instr[2,4]
      param_modes = [instr[1], instr[0]] # instr is read right to left

      # p "Current instr: #{instr}"
      case opcode
      when "01"
        params = get_params [
          @memory[ip + 1],
          @memory[ip + 2],
        ], param_modes

        addr = @memory[ip + 3]

        # execute instr
        val = params[0] + params[1]
        @memory[addr] = val

        jump = 4

      when "02"
        params = get_params [
          @memory[ip + 1],
          @memory[ip + 2],
        ], param_modes

        addr = @memory[ip + 3]

        # execute instr
        val = params[0] * params[1]
        @memory[addr] = val

        jump = 4

      when "03"
        addr = @memory[ip + 1]
        @memory[addr] = @device.id

        jump = 2

      when "04"
        addr = @memory[ip + 1]
        @output = @memory[addr]
        p "Write instruction output: #{@output}"
        jump = 2

      else
        p "ERROR: unknown instruction: #{instr}"
      end

      ip += jump
    end
  end

  def get_params params, param_modes
    out = []

    params.each_with_index do |param, i|
      if param_modes[i] == "0"
        out[i] = @memory[param]
      elsif param_modes[i] == "1"
        out[i] = param
      else
        p "Unrecognized parameter mode"
      end
    end

    out
  end

end

class IO
  attr_reader :id

  def initialize id
    @id = id
  end
end

input = File.read("./inputs/day05.in").strip

def process input
  input.split(",").map { |x| x.to_i }
end

memory = process input

ac = IO.new 1
computer = Computer.new memory, ac
computer.run
out = computer.output

p "Part 1: #{out}"
# 6069343
