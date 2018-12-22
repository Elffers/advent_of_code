require 'pp'

instr = {}
input = File.readlines("/Users/hsinghui/sandbox/advent_of_code/2018/inputs/day19.in").each_with_index do |line, i|
#
# input = File.readlines("/Users/hsinghui/sandbox/advent_of_code/2018/inputs/day19test.in").each_with_index do |line, i|
  next if i == 0
  o, a, b, c = line.strip.split(" ")
  instr[i-1] = [o.to_sym, a.to_i, b.to_i, c.to_i]
end
# pp instr

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

iptr = 2
reg = [1, 0, 0, 0, 0, 0]
ip = reg[iptr]

cycles = 0

input = instr[ip]
while input
  reg[iptr] = ip
  if ip == 2 && reg[3] == 0
    p "On cycle: #{cycles}, IP #{ip} #{reg.inspect}, #{input.join}"
    if reg[5] % reg[4] == 0
      reg[0] += reg[4]
    end
    reg[2] = 0
    reg[1] = reg[5]
    ip = 12
  else
  op = input.first
  reg = send(op, input, reg)

  ip = reg[iptr] + 1

  end
  if instr[ip].nil?
    p "Part 1: #{reg[0]}"
    break
  end
  input = instr[ip]
  cycles +=1
end
