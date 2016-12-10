class BotManager
  attr_accessor :bots, :output, :queue

  def initialize
    @bots = Hash.new { |h, k| h[k] = [] }
    @output = Hash.new  # value is a microchip
    @queue = Hash.new   # value is an instruction hash
  end

  def parse instr
    if /value\s(?<chip>\d+).+bot\s(?<id>\d+)/ =~ instr
      set_chips id, chip
    else
      enqueue instr
    end
  end

  def execute
    queue.each do |id, instr|
      deliver id
    end
  end

  def set_chips bot_id, chip
    bots[bot_id] << chip.to_i
  end

  def enqueue instr
    parts = instr.split " "

    bot_id = parts[1]
    low_dest    = parts[5]
    low_dest_id = parts[6]
    hi_dest     = parts[10]
    hi_dest_id  = parts[11]

    queue[bot_id] = {
      hi: { dest: hi_dest, id: hi_dest_id },
      low: { dest: low_dest, id: low_dest_id }
    }
  end

  def deliver id
    chips = bots[id]
    if (chips.count == 2) && queue[id]
      abort id if chips.sort == [17, 61]

      low, hi = chips.sort
      bots[id].clear

      instr = queue[id]

      hi_dest_id = instr[:hi][:id]
      if instr[:hi][:dest] == "output"
        output[hi_dest_id] = hi
      else
        bots[hi_dest_id] << hi
      end

      low_dest_id = instr[:low][:id]
      if instr[:low][:dest] == "output"
        output[low_dest_id] = low
      else
        bots[low_dest_id] << low
      end

      self.queue.delete id
    end
  end

end

if __FILE__ == $0
  input = File.read('day10.in').split("\n")
  b = BotManager.new

  input.each do |instr|
    b.parse instr
  end

  loop do
    b.execute
  end
end