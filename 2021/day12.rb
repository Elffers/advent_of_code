input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day12.in")

@map = Hash.new { |h, k| h[k] = [] }
input.each do |l|
  /(?<a>\w+)\-(?<b>\w+)/ =~ l
  @map[a] << b
  @map[b] << a
end

@paths = []
def path_from s, path, seen
  path << s
  if s.match?(/[a-z]/)
    seen[s] += 1
  end
  if s == "end"
    puts "PATH: #{path.join ","}"
    @paths << path
    return
  end

  ns = @map[s]
  if !ns.nil?
    ns.each do |c|
      if !seen.include? c
        s = seen.dup
        p = path.dup
        path_from c, p, s
      end
    end
  end
  path.pop
end

seen = Hash.new 0
path = []
path_from "start", path, seen

p "Part 1: #{@paths.count}"
