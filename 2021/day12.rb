require 'set'
input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day12test.in").split("\n")
# input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day12.in")

@map = Hash.new { |h, k| h[k] = [] }
input.each do |l|
  /(?<a>\w+)\-(?<b>\w+)/ =~ l
  @map[a] << b
  @map[b] << a if !a.match?(/[a-z]/) && b != "end"
end

p @map

n = ["start"]

# Find all paths from start to end
# Get rid of any path that doesn't end in "end"
# eliminate any that have "small cave" nodes more than once

@paths = []

def xpath_from n, path
  path << n
  if n == "end"
    @paths << path
    return
  end
  ns = @map[n]
  if !ns.nil?
    ns.each do |c|
      if !path.include?(c)
        path << c
      elsif c.match?(/[A-Z]/)
        path << c
      end
      path_from c, path
      p path
    end
  end
end

def path_from s, seen, path
  if s == "end"
    puts "GOT TO END: #{path}"
    puts
    @paths << path
    # return path
  else
    # mark small caves as visited
    if s.match?(/[a-z]/)
      seen << s
      puts "seen: #{seen}"
      puts
    end
    ns = @map[s]
    if !ns.nil?
      ns.each do |c|
        if !seen.include? c
          path << c
          path_from c, seen, path
          seen.delete c
        end
      end
      # puts "PATH: #{path}"
    end
  end
end

path_from "start", [], ["start"]
puts
puts
# p @paths
x = @paths.select { |p| p.last == "end" }
p x
puts
p x.size

