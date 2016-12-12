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

    bot_id      = parts[1]
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
      p id if chips.sort == [17, 61]

      low, hi = chips.sort
      bots[id].clear

      instr = queue[id]

      hi_instr= instr[:hi]
      deliver_to hi_instr, hi

      low_instr= instr[:low]
      deliver_to low_instr, low

      self.queue.delete id
    end
  end

  def deliver_to instr, chip
    id = instr[:id]

    if instr[:dest] == "output"
      output[id] = chip
    else
      bots[id] << chip
    end
  end

end

if __FILE__ == $0
  input = File.read('day10.in').split("\n")
  b = BotManager.new

  input.each do |instr|
    b.parse instr
  end

  while !b.queue.empty?
    b.execute
  end

  p b.output.values_at("0", "1", "2").reduce(:*)
end
