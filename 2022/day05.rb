input, instructions = File.read("/Users/hhhsu/sandbox/aoc/2022/inputs/day05.in").split("\n\n")

def init input
  stacks = Hash.new { |h, k| h[k] = [] }

  input = input.split("\n").reverse
  input.shift # get rid of column numbers

  # populate start state
  input.each do |s|
    i = 1
    while i < s.size
      x = s[i]
      if /\w/ =~ x
        col = i/4 + 1
        stacks[col] << x
      end
      i += 4
    end
  end
  stacks
end

def execute instructions, input
  stacks = init input
  instructions.split("\n").each do |instr|
    /move (?<n>\d+) from (?<src>\d+) to (?<dst>\d+)/ =~ instr
    yield stacks, n, src, dst
  end

  stacks.values.map do |stack|
    stack.last
  end.join
end

p "Part 1: #{execute instructions, input do |stacks, n, src, dst|
  n.to_i.times do
    crate = stacks[src.to_i].pop
    stacks[dst.to_i].push crate
  end
end}"

p "Part 2: #{execute instructions, input do |stacks, n, src, dst|
   stack  = stacks[src.to_i]

   i = stack.length - n.to_i
   crates = stack[i..-1]

   stacks[src.to_i] = stack[0...i]
   stacks[dst.to_i].concat crates
 end}"
