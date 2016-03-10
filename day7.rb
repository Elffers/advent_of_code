require 'tsort'

class Hash
  include TSort
  alias tsort_each_node each_key
  def tsort_each_child(node, &block)
    fetch(node).each(&block)
  end
end

class Circuit
  attr_accessor :wires, :unresolved

  def initialize
    @wires = {}
    @unresolved = Hash.new { |h, k| h[k] = [] }
  end

  def build(instructions)
    instructions.each_line do |instr|
      parse instr
    end
  end

  def build2(instructions)
    instructions.each_line do |instr|
      parse2 instr
    end

    @unresolved.tsort
  end

  def parse(instruction)
    left, out = instruction.split("->").map { |x| x.strip }
    signal =
      if /^(?<signal>\d+)/ =~ left
        signal.to_i
      elsif /(?<a>\w+) AND (?<b>\w+)/ =~ left
        wires[a] & wires[b]
      elsif /(?<a>\w+) OR (?<b>\w+)/ =~ left
        wires[a] | wires[b]
      elsif /(?<a>\w+) LSHIFT (?<bits>\w+)/ =~ left
        wires[a] << bits.to_i
      elsif /(?<a>\w+) RSHIFT (?<bits>\w+)/ =~ left
        wires[a] >> bits.to_i
      elsif /^NOT (?<a>\w+)/ =~ left
        [~wires[a]].pack("s").unpack("S").first
      end
    wires[out] = signal
  end

  def parse2(instruction)
    left, out = instruction.split("->").map { |x| x.strip }
    if /^(?<signal>\d+)/ =~ left
      unresolved[out]
    elsif /(?<a>\w+) AND (?<b>\w+)/ =~ left
      unresolved[out].push a, b
    elsif /(?<a>\w+) OR (?<b>\w+)/ =~ left
      unresolved[out].push a, b
    elsif /(?<a>\w+) LSHIFT (?<bits>\w+)/ =~ left
      unresolved[out].push a
    elsif /(?<a>\w+) RSHIFT (?<bits>\w+)/ =~ left
      unresolved[out].push a
    elsif /^NOT (?<a>\w+)/ =~ left
      unresolved[out].push a
    end
  end
end

if $0 == __FILE__
  instructions = File.read("day7_input.txt")
  circuit = Circuit.new
  circuit.build(instructions)
  p circuit.wires
end

