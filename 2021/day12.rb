input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day12.in")

@map = Hash.new { |h, k| h[k] = [] }
input.each do |l|
  /(?<a>\w+)\-(?<b>\w+)/ =~ l
  @map[a] << b
  @map[b] << a
end

def path_from s, path, seen, can_visit
  path << s
  if s.match?(/[a-z]/)
    seen[s] += 1
  end
  if s == "end"
    # puts "PATH: #{path.join ","}"
    @paths << path
    return
  end

  ns = @map[s]
  if !ns.nil?
    ns.each do |c|
      if can_visit.call c, seen
        v = seen.dup
        p = path.dup
        path_from c, p, v, can_visit
      end
    end
  end
  if s.match?(/[a-z]/)
    seen[s] -= 1
  end
  path.pop
end

@paths = []
seen = Hash.new 0
path = []
path_from "start", path, seen, lambda { |x, v| !v.include? x }

p "Part 1: #{@paths.count}"

def can_visit
  lambda do |s, seen|
    if s.match?(/[A-Z]/)
      true
    elsif s == "start"
      false
    elsif seen.values.max > 1
      seen[s] == 0
    else
      seen[s] < 2
    end
  end
end

@paths = []
seen = Hash.new 0
path = []
path_from "start", path, seen, can_visit

p "Part 2: #{@paths.count}"
