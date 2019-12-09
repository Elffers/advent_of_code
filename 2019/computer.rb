class Computer
  attr_accessor :memory, :inputs, :output, :ip

  def initialize memory, inputs
    @memory = memory
    @inputs = inputs # List of input values
    @phase = inputs.first
    @ip = 0
  end

  def receive signal
    @inputs << signal
  end

  def run
    jump = 0

    while @memory[ip] != 99
      instr = @memory[ip]
      opcode = instr % 100

      param1 = (instr/100)%10 == 0 ? @memory[@memory[ip+1]] : @memory[ip+1] # rescue nil
      param2 = (instr/1000)%10 == 0 ? @memory[@memory[ip+2]] : @memory[ip+2] #rescue nil

      case opcode
      when 1
        addr = @memory[ip+3]
        @memory[addr] = param1 + param2
        jump = 4

      when 2
        addr = @memory[ip+3]

        @memory[addr] = param1 * param2
        jump = 4

      when 3
        addr = @memory[ip + 1]
        if @inputs.empty?
          return @output
        end

        @memory[addr] = @inputs.shift
        jump = 2

      when 4
        @ip += 2
        @output = param1
        return @output
        # p "Write instruction output: #{@output}"

      when 5
        # Opcode 5 is jump-if-true: if the first parameter is non-zero, it
        # sets the instruction pointer to the value from the second parameter.
        # Otherwise, it does nothing.
          if param1 != 0
            @ip = param2
            jump = 0
          else
            jump = 3
          end

      when 6
        # Opcode 6 is jump-if-false: if the first parameter is zero, it sets
        # the instruction pointer to the value from the second parameter.
        # Otherwise, it does nothing.
          if param1 == 0
            @ip = param2
            jump = 0
          else
            jump = 3
          end

      when 7
        # Opcode 7 is less than: if the first parameter is less than the
        # second parameter, it stores 1 in the position given by the third
        # parameter. Otherwise, it stores 0.
        addr = @memory[ip + 3]
        if param1 < param2
          @memory[addr] = 1
        else
          @memory[addr] = 0
        end
        jump = 4

      when 8
        # Opcode 8 is equals: if the first parameter is equal to the second
        # parameter, it stores 1 in the position given by the third parameter.
        # Otherwise, it stores 0.
        addr = @memory[ip + 3]

        if param1 == param2
          @memory[addr] = 1
        else
          @memory[addr] = 0
        end
        jump = 4
      else
        p "ERROR: unknown instruction: #{instr}"
      end

      @ip += jump
    end
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
