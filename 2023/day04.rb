require 'set'

cards = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day04.in").split("\n")
# cards = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day04_test.in").split("\n")

sum = 0

CARDS = Hash.new 0
WINNING = {}

cards.each do |card|
  card_id, lists = card.split(": ")
  /Card\s+(?<id>\d+)/ =~ card_id
  id = id.to_i
  WINNING[id] = 0
  CARDS[id] += 1

  x, y = lists.split(" | ")

  winning = Set.new
  x.split.each {|n| winning << n.to_i }
  nums = y.split.map {|n| n.to_i }

  i = -1
  nums.each do |n|
    if winning.include? n
      WINNING[id] += 1
      i += 1
    end
  end

  if i > -1
    sum += 2**i
  end
end
p "Part 1: #{sum}"

WINNING.each_pair do |id, n|
    (1..n).each do |i|
      CARDS[id+i] += CARDS[id]
    end
end
p "Part 2: #{CARDS.values.sum}"
