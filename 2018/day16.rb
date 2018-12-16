require 'pp'
p1, p2 = File.read("/Users/hsinghui/sandbox/advent_of_code/2018/inputs/day16.in").split("\n\n\n")

samples  = {}
count = 0
p1 = p1.split("\n\n").map { |x| x.strip }
# p1.each do |sample|
# end

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

before = [3, 2, 1, 1]
input = "9 2 1 2".split(" ").map { |x| x.to_i}
after =  [3, 2, 2, 1]
# puts
# p mulr input, before
# puts

OPCODES.each do |op|
  b = before.dup
  # p "Before: #{ b}"
  out = send(op, input, b)
  if out == after
    p [op, out]
    count += 1
  end
end
p count
