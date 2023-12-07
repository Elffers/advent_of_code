require 'set'

cards = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day04.in").split("\n")
cards = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day04_test.in").split("\n")

sum = 0

CARDS = Hash.new 0

cards.each do |card|
  x, y = card.split(": ").last.split(" | ")
  winning = Set.new
  x.split.each {|n| winning << n.to_i }
  nums = y.split.map {|n| n.to_i }

  i = -1
  nums.each do |n|
    if winning.include? n
      i += 1
    end
  end

  if i > -1
    sum += 2**i
  end
end
p sum
# Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
