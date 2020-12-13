input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day07.in").map { |x| x.strip }

# process input into hash of bags with hash of bags they contain
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

def total_bags_for(key, graph)
  inner_bags = graph[key]
  if inner_bags.empty?
    return 0
  end
 inner_bags.map do |bag, count|
    count*total_bags_for(bag, graph) + count
 end.reduce(:+)
end

p2 = total_bags_for("shiny gold", bags)

p "part 1: #{p1}"
p "part 2: #{p2}"
