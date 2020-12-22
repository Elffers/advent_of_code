players = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day22.in").split("\n\n")

class Player
  attr_accessor :id, :hand, :curr

  def initialize id, hand
    @id = id
    @hand = hand
  end

  def play
    @curr = @hand.shift
  end

  def score
    hand.reverse.map.with_index do |card, i|
      card * (i+1)
    end.reduce(:+)
  end

  def take loser
    hand << curr
    hand << loser.curr
  end

  def triggers?
    hand.size >= curr
  end

  def lost?
    hand.empty?
  end
end

p1, p2 = players.map.with_index do |p, i|
  hand = p.split("\n")[1..-1].map { |x| x.to_i }
  Player.new i, hand
end

def combat p1, p2
  loop do
    return p2 if p1.lost?
    return p1 if p2.lost?

    p1.play
    p2.play

    p1.take p2 if p1.curr > p2.curr
    p2.take p1 if p2.curr > p1.curr
  end
end

winner = combat p1, p2
p "part 1: #{winner.score}"

