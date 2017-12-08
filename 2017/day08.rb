input = File.readlines('day8.in').map { |x| x.strip }
# input = File.readlines('day8_test.in').map { |x| x.strip }

$registers = Hash.new 0
$max = 0

def execute instr
  reg, op, val = instr.split

  case op
  when "inc"
    $registers[reg] += val.to_i
  when "dec"
    $registers[reg] -= val.to_i
  end

  if $registers[reg] > $max
    $max = $registers[reg]
  end
end

def is_true? cond
  reg, op, val = cond.split
  $registers[reg].send op, val.to_i
end

input.each do |line|
  instr, cond = line.split(" if ")
  if is_true?(cond)
    execute instr
  end
end

p $registers.values.max
p $max
