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
  a, b = args

  case instr
  when "set"
    if b.ord >= 97
      regs[a] = regs[b]
    else
      regs[a] = b.to_i
    end
  when "add"
    if b.ord >= 97
      regs[a] += regs[b]
    else
      regs[a] += b.to_i
    end
  when "mul"
    if b.ord >= 97
      regs[a] *= regs[b]
    else
      regs[a] *= b.to_i
    end
  when "mod"
    if b.ord >= 97
      regs[a] %= regs[b]
    else
      regs[a] %= b.to_i
    end
  when "snd"
    reg = a
    last_freq = regs[reg]
  when "rcv"
    reg = a
    if regs[reg] != 0
      p last_freq: last_freq
      break
    end
  when "jgz"
    reg = a
    offset = args.last.to_i
    if regs[reg] > 0
      pos += offset
      next
    end
  end

  pos += 1
end
