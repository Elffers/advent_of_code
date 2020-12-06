require 'set'
input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day06.in").split("\n\n")

count = 0
counts = input.map do |group|
  q = Set.new
  copy = group.dup.gsub("\n", "")
  copy.chars.each do |c|
    q << c
  end
  q.size

  answers = Hash.new 0
  members = group.split("\n")
  members.each do |m|
    m.chars.each do |c|
      answers[c] += 1
    end
  end

  all_yes = 0

  answers.each do |question, responses|
    if responses == members.size
      all_yes += 1
    end
  end

  count += all_yes
end

res = counts.reduce(:+)

p "part 1: #{res}"
p "part 2: #{count}"
