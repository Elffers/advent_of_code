input = File.read("../day12.in").split("\n")
# input = File.read("day12_test.in").split("\n")
programs = Hash.new { |h, k| h[k] = [] }

input.each do |line|
  k, v = line.split " <-> "
  programs[k.to_i] = v.split(",").map { |x| x.to_i }
end
# p programs

def count_if_contains val, programs
  queue = []
  seen = []
  queue.push val

  while !queue.empty?
    val = queue.shift
    if seen.include? val
      next
    end
    seen.push val
    queue.concat(programs[val].dup)
  end
  seen
end

seen = count_if_contains 0, programs
p seen.size # part 1

rest = programs.keys
groups = 0

while !rest.empty?
  val = rest.first
  seen = count_if_contains val, programs
  rest = rest - seen
  groups += 1
end
p groups

