require './day05.rb'

input = File.read("./inputs/day07.in").strip
# input = "3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0"
# input = "3,23,3,24,1002,24,10,24,1002,23,-1,23, 101,5,23,23,1,24,23,23,4,23,99,0,0"
MEMORY = process(input).freeze

def process sequence
  amp1 = Computer.new MEMORY.dup, [sequence[0], 0]
  amp1.run
  out1 = amp1.output
  # p amp1.memory

  amp2 = Computer.new MEMORY.dup, [sequence[1], out1]
  amp2.run
  out2 = amp2.output
  # p amp2.memory

  amp3 = Computer.new MEMORY.dup, [sequence[2], out2]
  amp3.run
  out3 = amp3.output
  # p amp3.memory

  amp4 = Computer.new MEMORY.dup, [sequence[3], out3]
  amp4.run
  out4 = amp4.output
  # p amp4.memory

  amp5 = Computer.new MEMORY.dup, [sequence[4], out4]
  amp5.run
  # p amp5.memory

  amp5.output
end

if __FILE__ == $0
  sequences = [0, 1, 2, 3, 4].permutation(5).to_a

  max = 0
  sequences.each do |seq|
    out = process seq
    max = out if out > max
  end

  p "Part 1: #{max}"
end
