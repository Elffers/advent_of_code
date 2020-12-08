require 'set'

input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day08.in").map { |x| x.strip.split }
# input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day08test.in").map { |x| x.strip.split }


accumulator = 0
pc = 0
seen = Hash.new 0

loop do
  seen[pc] += 1
  if seen[pc] == 2
    p seen
    p "part 1: #{accumulator}"
    break
  end

  instr, arg = input[pc]
  arg = arg.to_i
  p [pc, instr, arg, accumulator]
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



# end
# acc increases or decreases a single global value called the accumulator by the value given in the argument. For example, acc +7 would increase the accumulator by 7. The accumulator starts at 0. After an acc instruction, the instruction immediately below it is executed next.
#
# jmp jumps to a new instruction relative to itself. The next instruction to execute is found using the argument as an offset from the jmp instruction; for example, jmp +2 would skip the next instruction, jmp +1 would continue to the instruction immediately below it, and jmp -20 would cause the instruction 20 lines above to be executed next.
# nop stands for No OPeration - it does nothing. The instruction immediately below it is executed next.
