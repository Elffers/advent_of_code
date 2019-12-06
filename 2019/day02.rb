require "./intcode.rb"

input = File.read("./inputs/day02.in").strip

def process input
  input.split(",").map { |x| x.to_i }
end

MEMORY = process input

program = MEMORY.dup
noun = 12
verb = 2

computer = Computer.new(program, noun, verb)
out = computer.run

p "Part 1: #{out}"
# 3306701

target = 19690720

(0..99).each do |n|
  (0..99).each do |v|
    program = MEMORY.dup
    computer = Computer.new(program, n, v)
    out = computer.run

    if out == target
      p "Part 2: #{100 * computer.noun + computer.verb}"
      # 7621
      break
    end
  end
end
