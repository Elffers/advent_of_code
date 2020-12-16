require 'set'
rules, m, tickets = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day16.in").split("\n\n")

my_ticket = m.split("\n").last.split(",").map { |x| x.to_i }
tickets = tickets.split("\n").map { |t| t.split(",").map { |n| n.to_i } }

tickets.shift # get rid of header

ranges = []
ticket_rules = Hash.new { |h, k| h[k] = [] }
valid_tickets = []

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

# takes in all values of the same field, returns true if all values in the
# field satisfy the rule
def matches_rule? ranges, vals
  matches = vals.map do |n|
    is_valid? ranges, n
  end
  matches.all? { |x| x == true }
end

invalid = 0
tickets.each do |ticket|
  valid = true
  ticket.each do |n|
    if !is_valid? ranges, n
      invalid += n
      valid = false
    end
  end
  if valid
    valid_tickets << ticket
  end
end

p "part 1: #{invalid}"

matched_fields = Hash.new { |h, k| h[k] = [] }

s = Set.new(ticket_rules.keys)

(0..my_ticket.size-1).each do |i|
  f = valid_tickets.map { |x| x[i] } # look at the same field for all tickets

  ticket_rules.each do |field, rs|
    if matches_rule? rs, f
      matched_fields[field] << i # for whatever reason doing it the other way around doesn't work
    end
  end
end

final = Hash.new
seen = Set.new

while !s.empty?
  matched_fields.each do |k, v|
    copy = v.dup
    copy.each do |n|
      if seen.include? n
        v.delete n
      end
    end
    if v.length == 1
      seen << v.first
      final[k] = v.first
      s.delete k
    end
  end
end

res = 1
final.each do |k, v|
  if k.start_with? "departure"
    res *= my_ticket[v]
  end
end

p "part 2: #{res}"
