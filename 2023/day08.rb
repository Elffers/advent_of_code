cmds, data = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day08.in").split("\n\n")
# cmds, data = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day08_test.in").split("\n\n")

queue = cmds.chars

graph = Hash.new { |h, k| h[k] = [] }
data.split("\n").each do |line|
  /(?<key>\w+) = \((?<val1>\w+), (?<val2>\w+)\)/ =~ line
  graph[key] << val1
  graph[key] << val2
end

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
p steps
