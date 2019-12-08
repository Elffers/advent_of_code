require './computer.rb'

# input = "3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0"
# input = "3,23,3,24,1002,24,10,24,1002,23,-1,23, 101,5,23,23,1,24,23,23,4,23,99,0,0"
input = "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,
27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5"

input = "./inputs/day07.in"
MEMORY = process input

def process sequence
  signal = 0
  sequence.each do |s|
    amp = Computer.new MEMORY.dup, [s, signal]
    signal = amp.run
  end
  signal
end

def generate_signals
  sequences = [0, 1, 2, 3, 4].permutation(5).to_a
  sequences.map do |seq|
    process seq
  end
end

if __FILE__ == $0
  max = generate_signals.max
  p "Part 1: #{max}"
  # 199988
end
