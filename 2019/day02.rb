input = File.read("./inputs/day02.in").strip

def process input
  input.split(",").map { |x| x.to_i }
end

MEMORY = process input

noun = 12
verb = 2

program = MEMORY
program[1] = noun
program[2] = verb

def run program
  ip = 0
  while program[ip] != 99
    param1 = program[ip + 1]
    param2 = program[ip + 2]
    param3 = program[ip + 3]

    val = 0
    opcode = program[ip]

    case opcode
    when 1
      val = program[param1] + program[param2]
    when 2
      val = program[param1] * program[param2]
    end

    program[param3] = val
    ip += 4
  end

  program
end

run program
p "Part 1: #{program[0]}"
