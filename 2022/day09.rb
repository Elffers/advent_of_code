require 'set'
input = File.read("/Users/hhhsu/sandbox/aoc/2022/inputs/day09.in").split("\n")

def up h, t
  t[1] += 1
  if h[0] > t[0]
    t[0] += 1
  elsif h[0] < t[0]
    t[0] -= 1
  end
  t
end

def down h, t
  t[1] -= 1
  if h[0] > t[0]
    t[0] += 1
  elsif h[0] < t[0]
    t[0] -= 1
  end
  t
end

def left h, t
  t[0] -= 1
  if h[1] > t[1]
    t[1] += 1
  elsif h[1] < t[1]
    t[1] -= 1
  end
  t
end

def right h, t
  t[0] += 1
  if h[1] > t[1]
    t[1] += 1
  elsif h[1] < t[1]
    t[1] -= 1
  end
  t
end

def dir? head, tail
  x0, y0 = tail
  x1, y1 = head

  return :right if x1 - x0 > 1
  return :left if x0 - x1 > 1
  return :up if y1 - y0 > 1
  return :down if y0 - y1 > 1
end

def follow head, tail
  dir = dir? head, tail
  return tail if dir.nil?
  send dir, head, tail
end

def follow_cdr head, cdr
  out = []
  cdr.each.with_index do |tail, i|
    tail = follow head, tail
    out << tail
    head = tail
  end
  out
end

h = [0,0]
t = [0,0]
cdr = Array.new(9) {|i| [0,0]}

visited = Set.new
visited << t

path = Set.new
path << cdr.last

input.each do |instr|
  dir, n = instr.split(" ")
  n.to_i.times do
    case dir
    when "U"
      h[1] += 1
    when "D"
      h[1] -= 1
    when "R"
      h[0] += 1
    when "L"
      h[0] -= 1
    end
    t = follow h, t
    visited << t

    cdr = follow_cdr h, cdr
    path << cdr.last
  end
end

p "Part 1: #{visited.size}"
p "Part 2: #{path.size}"
