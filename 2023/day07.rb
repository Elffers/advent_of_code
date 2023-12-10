require 'pp'
input = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day07.in").split("\n")
# input = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day07_test.in").split("\n")

class CamelHand
  include Comparable
  attr_reader :hand, :bid, :index

  RANKS = %w[2 3 4 5 6 7 8 9 T J Q K A]

  def <=>(other)
    chars = self.hand.chars.zip(other.hand.chars)
    chars.each do |(x, y)|
      val = RANKS.index(x) <=> RANKS.index(y)
      return val if val != 0
    end
    0
  end

  # data: "32T3K 765"
  def initialize data, i
    @hand = data.split.first
    @bid = data.split.last.to_i
    @index = i
  end

  def type
    counts = Hash.new 0
    hand.chars.each do |x|
      counts[x] += 1
    end

    if counts.values.include? 5 # 5 of a kind
      return 7
    elsif counts.values.include? 4 # 4 of a kind
      return 6
    elsif counts.values.include? 3
      if counts.values.include? 2 # full house
        return 5
      else # 3 of a kind
        return 4
      end
    elsif counts.values.include? 2
      if counts.keys.size == 3 # two pair
        return 3
      else # one pair
        return 2
      end
    else # high card
      return 1
    end
  end
end

cards = input.map.with_index { |x, i| CamelHand.new x, i }
types = Hash.new { |h, k| h[k] = [] }
cards.each do |card|
  types[card.type] << card
end
sorted = []
(1..7).each do |i|
  types[i].sort.each do |hand|
    sorted << hand
  end
end
scores =  sorted.map.with_index do |x, i|
  x.bid * (i+1)
end
p scores.reduce(:+)


