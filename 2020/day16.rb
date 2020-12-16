require 'pp'
require 'set'
rules, t, tickets = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day16.in").split("\n\n")
# rules, t, tickets = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day16test.in").split("\n\n")

my_ticket = t.split("\n").last.split(",").map { |x| x.to_i }
tickets = tickets.split("\n").map { |t| t.split(",").map { |n| n.to_i } }

tickets.shift # get rid of header

ranges = []
ticket_rules = Hash.new { |h, k| h[k] = [] }

rules = rules.split("\n")
rules.each do |rule|
  /^(?<field>.+): (?<x1>\d+)\-(?<y1>\d+) or (?<x2>\d+)\-(?<y2>\d+)/ =~ rule
  r1 = (x1.to_i..y1.to_i)
  r2 = (x2.to_i..y2.to_i)
  ranges << r1
  ranges << r2

  ticket_rules[field] = [r1, r2]
end

def is_valid? ranges, n
  ranges.map do |range|
    !range.cover? n
  end.any? { |x| x == false }
end

def matches_rule? ranges, vals
  matches = vals.map do |n|
    is_valid? ranges, n
  end
  matches.all? { |x| x == true }
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

matches = Hash.new { |h, k| h[k] = [] }
matched_fields = Hash.new

s = Set.new(0..my_ticket.size-1)

# while !s.empty?
  p s.size
  p matched_fields

  (0..my_ticket.size-1).each do |i|
    f = tickets.map { |x| x[i] } # look at the same field for all tickets

    ticket_rules.each do |field, rs|
      if !matched_fields[field].nil?
        next
      end
      if matches_rule? rs, f
        matches[i] << field
      end
    end

    if matches[i].length == 1
      field = matches[i].first
      matched_fields[field] = i
      s.delete i
    end
  end
# end

pp matches

pp matched_fields


