rules, t, tickets = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day16.in").split("\n\n")

my_ticket = t.split("\n").last.split(",").map { |x| x.to_i }
tickets = tickets.split("\n").map { |t| t.split(",").map { |n| n.to_i } }

tickets.shift # get rid of header

ranges = []

rules = rules.split("\n")
rules.each do |rule|
  /^(\w+): (?<x1>\d+)\-(?<y1>\d+) or (?<x2>\d+)\-(?<y2>\d+)/ =~ rule
  r1 = (x1.to_i..y1.to_i)
  r2 = (x2.to_i..y2.to_i)
  ranges << r1
  ranges << r2
end

def is_valid? ranges, n
  ranges.map do |range|
    !range.cover? n
  end.any? { |x| x == false }
end

invalid = 0
tickets.each do |ticket|

  ticket.each do |n|
    if !is_valid? ranges, n
      invalid += n
    end
  end

end

p "part 1: #{invalid}"
