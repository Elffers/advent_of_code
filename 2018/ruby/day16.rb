require 'pp'
require 'scanf'
p1, p2 = File.read("/Users/hsinghui/sandbox/advent_of_code/2018/inputs/day16.in").split("\n\n\n")
p1 = p1.split("\n\n").map { |x| x.strip }

def find_opcodes before, input, after
  count = 0
  codes = []
  OPCODES.each do |op|
    b = before.dup
    out = send(op, input, b)
    if out == after
      count += 1
      codes << op
    end
  end
  [count, codes]
end

OPCODES = %i[
  addr
  addi
  mulr
  muli
  banr
  bani
  borr
  bori
  setr
  seti
  gtir
  gtri
  gtrr
  eqir
  eqri
  eqrr
]

def addr input, reg
  o, a, b, c = input
  reg[c] = reg[a] + reg[b]
  reg
end

def addi input, reg
  o, a, b, c = input
  reg[c] = reg[a] + b
  reg
end

def mulr input, reg
  o, a, b, c = input
  reg[c] = reg[a] * reg[b]
  reg
end

def muli input, reg
  o, a, b, c = input
  reg[c] = reg[a] * b
  reg
end

def banr input, reg
  o, a, b, c = input
  reg[c] = reg[a] & reg[b]
  reg
end

def bani input, reg
  o, a, b, c = input
  reg[c] = reg[a] & b
  reg
end

def borr input, reg
  o, a, b, c = input
  reg[c] = reg[a] | reg[b]
  reg
end

def bori input, reg
  o, a, b, c = input
  reg[c] = reg[a] | b
  reg
end

def setr input, reg
  o, a, b, c = input
  reg[c] = reg[a]
  reg
end

def seti input, reg
  o, a, b, c = input
  reg[c] = a
  reg
end

def gtir input, reg
  o, a, b, c = input
  if a > reg[b]
    reg[c] = 1
  else
    reg[c] = 0
  end
  reg
end

def gtri input, reg
  o, a, b, c = input
  if reg[a] > b
    reg[c] = 1
  else
    reg[c] = 0
  end
  reg
end

def gtrr input, reg
  o, a, b, c = input
  if reg[a] > reg[b]
    reg[c] = 1
  else
    reg[c] = 0
  end
  reg
end

def eqir input, reg
  o, a, b, c = input
  if a == reg[b]
    reg[c] = 1
  else
    reg[c] = 0
  end
  reg
end

def eqri input, reg
  o, a, b, c = input
  if reg[a] == b
    reg[c] = 1
  else
    reg[c] = 0
  end
  reg
end

def eqrr input, reg
  o, a, b, c = input
  if reg[a] == reg[b]
    reg[c] = 1
  else
    reg[c] = 0
  end
  reg
end


count = 0
opcodes = {}

p1.each do |sample|
  regs = sample.scanf("Before: [%d, %d, %d, %d]\n %d %d %d %d\nAfter: [%d, %d, %d, %d]")
  before = regs[0,4]
  input = regs[4, 4]
  after = regs[8, 4]

  num, codes = find_opcodes before, input, after
  # p [num, codes]

  if num == 1
    code = input.first
    opcodes[code] = codes.first
  else
    rest = codes - opcodes.values
    if rest.size == 1
      code = input.first
      opcodes[code] = rest.first
    end
  end

  # Part 1
  if num >= 3
    count += 1
  end
end

p "Part 1: #{count}"

instr = p2.strip.split("\n").map do |input|
  input.split(" ").map { |x| x.to_i }
end

reg = [0, 0, 0, 0]
while !instr.empty?
  input = instr.shift
  op = opcodes[input.first]
  out = send(op, input, reg)
  reg = out
end

p "Part 2: #{reg.first}"
