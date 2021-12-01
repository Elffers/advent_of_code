class Computer
  attr_accessor :memory, :inputs, :output, :ip, :relative_base

  def initialize memory, inputs
    @memory = Hash.new 0
    # p memory.size
    memory.each_with_index do |x, i|
      @memory[i] = x
    end
    # p @memory
    @inputs = inputs # List of input values
    @phase = inputs.first
    @ip = 0
    @relative_base = 0
    @output = []
  end

  def receive signal
    @inputs << signal
  end

  def get_param ip, n
    instr = @memory[ip]
    div = 10**(n+1)
    mode = (instr/div)%10
    param = ip + n

    case mode
    when 0
      @memory[@memory[param]]
    when 1
      return @memory[param]
    when 2
      p two: true, rb: @relative_base, param: @memory[param]

      return @memory[@relative_base+@memory[param]]
    end
  end

  def run
    jump = 0

    while @memory[ip]%100 != 99
      instr = @memory[ip]
      opcode = instr % 100

      param1 = get_param ip, 1
      param2 = get_param ip, 2

      p instr: instr, param1: param1, param2: param2, rb: relative_base, ip: ip

      case opcode
      when 1
        addr = @memory[ip+3]
        @memory[addr] = param1 + param2
        p "Wrote: #{@memory[addr]} at #{addr}"
        jump = 4

      when 2
        addr = @memory[ip+3]

        @memory[addr] = param1 * param2
        p "Wrote: #{@memory[addr]} at #{addr}"
        jump = 4

      when 3
        addr = param1
        # if @inputs.empty?
        #   @memory[addr] = 0
        # end

        @memory[addr] = @inputs.shift
        p "INPUT: Wrote: #{@memory[addr]} at #{addr}"
        jump = 2

      when 4
        @output << param1
        jump = 2

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
      when 9
        @relative_base += param1
        jump = 2
      else
        p "ERROR: unknown instruction: #{instr}"
      end
      # p self
      @ip += jump
    end
    @output
  end
end

def process input
  program = File.read(input).strip
  program.split(",").map { |x| x.to_i }
end

input = "./inputs/day09.in"
memory = process input
# test = "104,1125899906842624,99"
# test = "1102,34915192,34915192,7,4,7,99,0"
# test = "109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99"
# memory = test.chomp.split(",").map { |x| x.to_i }

computer = Computer.new memory.dup, [1]

out = computer.run
p out
