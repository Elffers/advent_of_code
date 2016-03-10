require 'tsort'

class Hash
  include TSort
  alias tsort_each_node each_key
  def tsort_each_child(node, &block)
    fetch(node).each(&block)
  end
end

class Circuit
  MAX_SIGNAL = 65_535
  attr_accessor :wires, :unresolved, :todo

  def initialize
    @wires = {}
    @unresolved = Hash.new { |h, k| h[k] = [] }
    @todo = Hash.new { |h, k| h[k] = [] }
  end

  def build(instructions)
    instructions.each_line do |instr|
      parse instr
    end

    evaluate
  end

  def evaluate
    resolved = unresolved.tsort
    resolved.each do |gate|
      # p todo[gate]
      p wires[gate] if gate == "b"
      wires[gate] = calculate(todo[gate])
      # p wires[gate]
    end
  end

  def calculate(instruction)
    operation, a, b = instruction
    case operation
    when :"="
      a
    when :"=="
      decode(a)
    when :>>
      decode(a) >> b
    when :<<
      decode(a) << b
    when :&
      decode(a) & decode(b)
    when :|
      decode(a) | decode(b)
    when :~
      [~decode(a)].pack("s").unpack("S").first
    end
  end

  def parse(instruction)
    left, out = instruction.split("->").map { |x| x.strip }
    if /^(?<signal>\d+)$/ =~ left
      unresolved[out]
      todo[out].push :"=", signal.to_i
    elsif /^(?<a>\w+)$/ =~ left
      unresolved[out].push a
      todo[out].push :"==", a
    elsif /(?<a>\w+) AND (?<b>\w+)/ =~ left
      add_dependency out, a, b
      todo[out].push :&, a, b
    elsif /(?<a>\w+) OR (?<b>\w+)/ =~ left
      add_dependency out, a, b
      todo[out].push :|, a, b
    elsif /(?<a>\w+) LSHIFT (?<bits>\w+)/ =~ left
      add_dependency out, a
      todo[out].push :<<, a, bits.to_i
    elsif /(?<a>\w+) RSHIFT (?<bits>\w+)/ =~ left
      add_dependency out, a
      todo[out].push :>>, a, bits.to_i
    elsif /^NOT (?<a>\w+)/ =~ left
      add_dependency out, a
      todo[out].push :~, a
    else
      raise "unparseable #{instruction}"
    end
  end

  def decode gate
    if gate =~ /\A\d+\z/
      gate.to_i
    else
      wires[gate]
    end
  end

  def add_dependency(out, *gates)
    named = gates.select { |gate| gate !~ /\A\d+\z/ }

    unresolved[out].concat named
  end

end

if $0 == __FILE__
  instructions = File.read("day7_input.txt")
  circuit = Circuit.new
  circuit.build(instructions)

  # circuit.unresolved.tsort.take_while { |w| w != 'a' }.each { |w| puts "#{w}: #{circuit.wires[w]}" }
  p circuit.wires["a"]

  circuit.todo["b"] = [:"=", circuit.wires["a"]]
  circuit.wires.clear
  circuit.evaluate
  p circuit.wires["a"]
end

