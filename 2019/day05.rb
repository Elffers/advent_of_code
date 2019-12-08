require './computer.rb'

input = "./inputs/day05.in"
memory = process input

if __FILE__ == $0
  ac = IO.new 1
  computer = Computer.new memory.dup, [ac.id]
  out = computer.run

  p "Part 1: #{out}"
  # 6069343

  ac = IO.new 5
  computer = Computer.new memory.dup, [ac.id]
  out = computer.run

  p "Part 2: #{out}"
  # 3188550
end
