input = File.read("../day23.in").strip.split("\n")

regs = {
  "a" => 0,
  "b" => 0,
  "c" => 0,
  "d" => 0,
  "e" => 0,
  "f" => 0,
  "g" => 0
}
pos = 0
result = 0

while pos < input.size
  line = input[pos]
  instr, *args = line.split " "
  case instr
  when "set"
    a, b = args
    if b.ord >= 97
      regs[a] = regs[b]
    else
      regs[a] = b.to_i
    end
    pos += 1
  when "sub"
    a, b = args
    if b.ord >= 97
      regs[a] -= regs[b]
    else
      regs[a] -= b.to_i
    end
    pos += 1
  when "mul"
    result += 1
    a, b = args
    if b.ord >= 97
      regs[a] *= regs[b]
    else
      regs[a] *= b.to_i
    end
    pos += 1
  when "jnz"
    reg = args.first
    offset = args.last.to_i
    if regs[reg] != 0
      pos += offset
    else
      pos += 1
    end
  end
end
p result
