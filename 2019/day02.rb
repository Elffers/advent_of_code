input = File.read("./inputs/day02.in").strip

def process input
  input.split(",").map { |x| x.to_i }
end

MEMORY = process input

def run program, noun, verb
  program[1] = noun
  program[2] = verb

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

  program[0]
end

program = MEMORY.dup
noun = 12
verb = 2

out = run program, noun, verb

p "Part 1: #{out}"
# 3306701

target = 19690720

(0..99).each do |n|
  (0..99).each do |v|
    program = MEMORY.dup
    out = run program, n, v

    if out == target
      p "Part 2: #{100 * n + v}"
      # 7621
      break
    end
  end
end
