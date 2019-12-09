class Computer
  attr_accessor :memory

  def initialize memory
    @memory = memory
  end

  def run
    ip = 0

    while @memory[ip] != 99
      param1 = @memory[ip + 1]
      param2 = @memory[ip + 2]
      param3 = @memory[ip + 3]

      val = 0
      opcode = @memory[ip]

      case opcode
      when 1
        val = @memory[param1] + @memory[param2]
      when 2
        val = @memory[param1] * @memory[param2]
      end

      @memory[param3] = val
      ip += 4
    end

    @memory[0]
  end
end
