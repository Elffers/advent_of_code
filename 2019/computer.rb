class Computer
  attr_accessor :memory, :inputs, :output

  def initialize memory, inputs
    @memory = memory
    @inputs = inputs # List of input values
  end

  def receive signal
    @inputs << signal
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
        @memory[addr] = @inputs.shift

        jump = 2

      when "04"
        addr = @memory[ip + 1]
        if instr[-3] == "0"
          @output = @memory[addr]
        elsif instr[-3] == "1"
          @output = addr
        end
        p "Write instruction output: #{@output}"

        jump = 2

      when "05"
        # Opcode 5 is jump-if-true: if the first parameter is non-zero, it
        # sets the instruction pointer to the value from the second parameter.
        # Otherwise, it does nothing.
          params = get_params [
            @memory[ip + 1],
            @memory[ip + 2]
          ], param_modes

          if params[0] != 0
            ip = params[1]
            jump = 0
          else
            jump = 3
          end

      when "06"
        # Opcode 6 is jump-if-false: if the first parameter is zero, it sets
        # the instruction pointer to the value from the second parameter.
        # Otherwise, it does nothing.
          params = get_params [
            @memory[ip + 1],
            @memory[ip + 2]
          ], param_modes

          if params[0] == 0
            ip = params[1]
            jump = 0
          else
            jump = 3
          end

      when "07"
        # Opcode 7 is less than: if the first parameter is less than the
        # second parameter, it stores 1 in the position given by the third
        # parameter. Otherwise, it stores 0.
          params = get_params [
            @memory[ip + 1],
            @memory[ip + 2]
          ], param_modes

          addr = @memory[ip + 3]

          if params[0] < params[1]
            @memory[addr] = 1
          else
            @memory[addr] = 0
          end
          jump = 4

      when "08"
        # Opcode 8 is equals: if the first parameter is equal to the second
        # parameter, it stores 1 in the position given by the third parameter.
        # Otherwise, it stores 0.
          params = get_params [
            @memory[ip + 1],
            @memory[ip + 2]
          ], param_modes

          addr = @memory[ip + 3]

          if params[0] ==  params[1]
            @memory[addr] = 1
          else
            @memory[addr] = 0
          end
          jump = 4
      else
        p "ERROR: unknown instruction: #{instr}"
      end

      ip += jump
    end
    @output
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

def process input
  program = File.read(input).strip
  program.split(",").map { |x| x.to_i }
end

