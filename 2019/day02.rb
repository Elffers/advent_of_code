require "./intcode.rb"

input = File.read("./inputs/day02.in").strip

def process input
  input.split(",").map { |x| x.to_i }
end

MEMORY = process input

program = MEMORY.dup
noun = 12
verb = 2

computer = Computer.new(program)
out = computer.run noun, verb

p "Part 1: #{out}"
# 3306701

target = 19690720

(0..99).each do |n|
  (0..99).each do |v|
    program = MEMORY.dup
    computer = Computer.new(program)
    out = computer.run n, v

    if out == target
      p "Part 2: #{100 * n + v}"
      # 7621
      break
    end
  end
end
