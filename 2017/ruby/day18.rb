input = File.read("../day18.in").strip.split("\n")

# input = <<TEST
# set a 1
# add a 2
# mul a a
# mod a 5
# snd a
# set a 0
# rcv a
# jgz a -1
# set a 1
# jgz a -2
# TEST
# input = input.split "\n"

regs = Hash.new 0
last_freq = nil
pos = 0

loop do
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
  when "add"
    a, b = args
    if b.ord >= 97
      regs[a] += regs[b]
    else
      regs[a] += b.to_i
    end
    pos += 1
  when "mul"
    a, b = args
    if b.ord >= 97
      regs[a] *= regs[b]
    else
      regs[a] *= b.to_i
    end
    pos += 1
  when "mod"
    a, b = args
    if b.ord >= 97
      regs[a] %= regs[b]
    else
      regs[a] %= b.to_i
    end
    pos += 1
  when "snd"
    reg = args.first
    last_freq = regs[reg]
    pos += 1
  when "rcv"
    reg = args.first
    if regs[reg] != 0
      p last_freq: last_freq
      break
    end
    pos += 1
  when "jgz"
    reg = args.first
    offset = args.last.to_i
    if regs[reg] > 0
      pos += offset
    else
      pos += 1
    end
  end
end
