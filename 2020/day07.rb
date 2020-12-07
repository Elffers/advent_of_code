require 'pp'
input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day07.in").map { |x| x.strip }
input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day07test.in").map { |x| x.strip }
#
bags = Hash.new { |h, k| h[k] = Hash.new }

input.each do |line|
  k, vals = line.split("contain")
  /(?<key>\w+ \w+) bag/ =~ k

  inner_bags = {}
  vals.split(",").each do |v|
    match = /(?<num>\d+) (?<bag>\w+ \w+) bag/ =~ v
    if match
      inner_bags[bag] = num.to_i
    end
  end
  bags[key] = inner_bags
end


def contains_shiny_gold(graph, key)
  queue = graph[key].keys.dup
  while !queue.empty?
    val = queue.shift
    queue.compact!
    if val == "shiny gold"
      return true
    end
    queue.concat(graph[val].keys)
  end
  return false
end

p1 = 0

bags.keys.each do |bag|
  p1 += 1 if contains_shiny_gold(bags, bag)
end

pp bags

def total_bags_for(key, graph)
  inner_bags = graph[key]
  queue = graph[key].keys.dup

  while !queue.empty?
    queue.compact!
    val = queue.shift
  end

end

# graph["shiny gold"].map do |inner_bags|
#   inner
# end

p "part 1: #{p1}" #326
# p "part 2: #{p2}"
