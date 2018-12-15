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
class Process
  attr_accessor :queue, :id, :regs, :input, :duo

  def initialize id, input
    @input = input
    @id = id
    @queue = []
    @regs = Hash.new
  end

  def rcv reg
    if !@queue.empty?
      val = @queue.shift
      regs[reg] = val
    # else
      # wait until queue is populated?
    end
  end

  def link process
    @duo = process
  end

  def run
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
        val = a
        @duo.queue << val
      when "rcv"
        rcv a
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
  end
end

p0 = Process.new(0, input)
p1 = Process.new(1, input)

p0.link p1
p1.link p0

