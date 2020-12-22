players = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day22.in").split("\n\n")

p1, p2 = players.map do |p|
  p.split("\n")[1..-1].map { |x| x.to_i }
end

def score hand
  hand.reverse.map.with_index do |card, i|
    card * (i+1)
  end.reduce(:+)
end

def play p1, p2
  moves = 0
  loop do
    if p1.empty? || p2.empty?
      return p1.empty? ? score(p2) : score(p1)
    end

    curr1 = p1.shift
    curr2 = p2.shift

    if curr1 > curr2
      p1 << curr1
      p1 << curr2
    end
    if curr2 > curr1
      p2 << curr2
      p2 << curr1
    end

    moves += 1
  end
end

res = play p1, p2
p "part 1: #{res}"
