require './day05.rb'

input = File.read("./inputs/day07.in").strip
# input = "3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0"
# input = "3,23,3,24,1002,24,10,24,1002,23,-1,23, 101,5,23,23,1,24,23,23,4,23,99,0,0"
MEMORY = process(input).freeze

def process sequence
  amp1 = Computer.new MEMORY.dup, [sequence[0], 0]
  out1 = amp1.run

  amp2 = Computer.new MEMORY.dup, [sequence[1], out1]
  out2 = amp2.run

  amp3 = Computer.new MEMORY.dup, [sequence[2], out2]
  out3 = amp3.run

  amp4 = Computer.new MEMORY.dup, [sequence[3], out3]
  out4 = amp4.run

  amp5 = Computer.new MEMORY.dup, [sequence[4], out4]
  amp5.run
end

def generate_sequence
  sequences = [0, 1, 2, 3, 4].permutation(5).to_a
  sequences.map do |seq|
    process seq
  end.max
end


if __FILE__ == $0
  max = generate_sequence
  p "Part 1: #{max}"
end
