cmds, data = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day08.in").split("\n\n")

graph = Hash.new { |h, k| h[k] = [] }
data.split("\n").each do |line|
  /(?<key>\S+) = \((?<val1>\S+), (?<val2>\S+)\)/ =~ line
  graph[key] << val1
  graph[key] << val2
end

def part1 graph, cmds
  queue = cmds.chars
  curr = "AAA"
  dest = "ZZZ"
  steps = 0

  while curr != dest
    cmd = queue.shift
    queue << cmd
    case cmd
    when "L"
      curr = graph[curr].first
    when "R"
      curr = graph[curr].last
    end
    steps +=1
  end
  steps
end

def finished? nodes
  nodes.all? { |node| node[2] == "Z" }
end

def part2 graph, cmds
  queue = cmds.chars
  nodes = graph.keys.select { |key| key[2] == "A" }
  steps = 0

  factors = Array.new(nodes.size)

  until finished?(nodes)
    cmd = queue.shift
    queue << cmd
    case cmd
    when "L"
      nodes = nodes.map { |n| graph[n].first }
    when "R"
      nodes = nodes.map { |n| graph[n].last}
    end
    steps +=1
    nodes.each.with_index do |n, i|
      if n[2] == "Z"
        factors[i] = steps
      end
    end
    break if factors.all? { |f| !f.nil? }
  end

  out = factors.first
  factors.each.with_index do |f, i|
    out = out.lcm(f)
  end
  out
end

p "Part 1: #{part1 graph, cmds}"
p "Part 2: #{part2 graph, cmds}"
