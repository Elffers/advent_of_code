require 'pp'

input = File.readlines("../day13.in").map { |x| x.strip }
# input = <<TEST
# 0: 3
# 1: 2
# 4: 4
# 6: 4
# TEST

# input = input.split("\n")

$firewall = {}

input.each do |line|
  layer, range = line.split(": ")
  $firewall[layer.to_i] = {
    range: range.to_i,
    down: true,
    scanner: 1,
  }
end

def move_scanner
  $firewall.each do |k, v|
    current = if v[:down]
                v[:scanner] += 1
              else
                v[:scanner] -= 1
              end
    v[:down] = false if current == v[:range]
    v[:down] = true if current == 1
  end
end

$layers = (0..$firewall.keys.last).to_a
penalty = 0

while !$layers.empty?
  packet = $layers.shift

  state = $firewall[packet]
  if !state.nil?

    if state[:scanner] == 1
      penalty += (packet * state[:range])
    end
  end

  move_scanner
end

p penalty
