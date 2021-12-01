require 'pp'

head, input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day19test.in").split("\n\n")
# head, input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day19.in").split("\n\n")

@rules = {}
head.split("\n").each do |r|
  k, v = r.split(": ")
  if v == '"a"' || v == '"b"'
    @rules[k] = v.delete('"')
  else
    @rules[k] = v.delete(' ').split("|")
  end
end

#72: b and 71: a
# {"0"=>"4 1 5",
#  "1"=>"2 3 | 3 2",
#  "2"=>"4 4 | 5 5",
#  "3"=>"4 5 | 5 4",
#  "4"=>"a",
#  "5"=>"b"}
#

def is_terminal? r
  r == "a" || r == "b"
end

def regex_for rule
  re = ""

  queue = rule.first.chars

  while !queue.empty?
    r = queue.shift
    if is_terminal? r
      re += r
    end



  end




  Regex.new re
end


def match rule, s
  curr = s[0]
  cons = s[1..-1]

  # handle terminal
  if is_terminal? rule
    if curr == rule
      s = cons
      p "new string: #{s}" # TODO refactor
      return true
    else
      return false
    end
  end

  # handle single sequence
  if rule.size == 1
    queue = rule.first.chars

    while !queue.empty?
      p "queue: #{queue}, s: #{s}"
      r = queue.shift

      seq = @rules[r]

      match =  match seq, s, queue

      if !match
        return false
      else
        s = cons
      end
    end

    p "done with queue"

    s.empty?
  end
  # TODO handle seq | seq
end


data = input.split("\n")

p match rule, data[0] # FIXME test

# count = 0
# rule = @rules["0"]
# data.each do |s|
#   count += 1 if match rule, s
# end

# p "part 1: #{count}"

