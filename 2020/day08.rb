input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day08.in").map { |x| i, a = x.split " " ; [i, a.to_i] }

def find_loop input
  accumulator = 0
  pc = 0
  seen = Hash.new 0

  loop do
    seen[pc] += 1
    if seen[pc] == 2
      return accumulator, false
    end

    if pc == input.length
      return accumulator, true
    end

    instr, arg = input[pc]

    case instr
    when "acc"
      accumulator += arg
      pc += 1
    when "jmp"
      pc += arg
    when "nop"
      pc += 1
    end
  end
end

p "part 1: #{find_loop(input)[0]}"

input.each_with_index do |line, i|
  instr, arg = line
  fixed = input.dup
  if instr == "nop"
    fixed[i] = ["jmp", arg]
  end
  if instr == "jmp"
    fixed[i] = ["nop", arg]
  end

  acc, halts = find_loop fixed
  if halts
    p "part 2: #{acc}"
  end
end
