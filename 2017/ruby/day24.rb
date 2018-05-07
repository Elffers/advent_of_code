require 'pp'

input = File.readlines("../day24.in").map { |x| x.chomp }
# input = <<TEST
# 0/2
# 2/2
# 2/3
# 3/4
# 3/5
# 0/1
# 10/1
# 9/10
# TEST
# input = input.split("\n")
$ports = Hash.new { |h, k| h[k] = [] }
$components = []

input.map { |x| x.split("/") }.each do |a, b|
  a, b = a.to_i, b.to_i
  $components << [a, b].sort
  $ports[a] << b
  $ports[b] << a unless $ports[b].include?(a)
end


def bridge port, components
  return 0 if components.empty?

  children = $ports[port]
  children.map { |child|
    component = [port, child].sort
    if components.include? component
      remaining = components - [component]
      score = bridge child, remaining
      score + port + child
    else
      next 0
    end
  }.max
end

port = 0
p bridge port, $components

def bridge_length port, components
  return 0 if components.empty?

  children = $ports[port]
  children.map { |child|
    component = [port, child].sort
    if components.include? component
      remaining = components - [component]
      score = bridge_length child, remaining
      score + port + child
    else
      next 0
    end
  }.max
end

port = 0
p bridge port, $components
