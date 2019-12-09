require "./intcode.rb"

input = File.read("./inputs/day02.in").strip

def process input
  input.split(",").map { |x| x.to_i }
end

MEMORY = process input

program = MEMORY.dup
noun = 12
verb = 2
program[1] = noun
program[2] = verb

computer = Computer.new(program)
out = computer.run

p "Part 1: #{out}"
# 3306701

target = 19690720

(0..99).each do |noun|
  (0..99).each do |verb|
    program = MEMORY.dup
    program[1] = noun
    program[2] = verb

    computer = Computer.new(program)
    out = computer.run

    if out == target
      p "Part 2: #{100 * noun + verb}"
      # 7621
      break
    end
  end
end
