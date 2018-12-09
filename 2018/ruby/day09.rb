class Circle
  attr_accessor :current

  def initialize val
    @current = Node.new val
    @current.next = @current
    @current.prev = @current
  end

  def to_s
    s = []
    seen = []
    current = @current

    while !seen.include? current
      seen << current
      s << current.val
      current = current.next
    end
    s
  end
end

class Node
  attr_accessor :val, :next, :prev

  def initialize val
    @val = val
    @next, @prev = nil, nil
  end

  def link val
    node = Node.new val

    if self.prev == self
      self.prev = node
    end

    self.next.prev = node
    node.next = self.next
    node.prev = self

    self.next = node
  end

  def unlink node
    self.next = node.next
  end
end

def play(players, last_marble)
  circle = Circle.new 0
  current = circle.current
  marble = 0

  player = 0
  scores = Hash.new 0

  while marble < last_marble
    marble += 1

    if marble % 23 == 0
      6.times do
        current = current.prev
      end

      score = current.val + marble
      scores[player] += score

      prev = current.prev
      to_unlink = current
      prev.unlink to_unlink

    else
      2.times do
        current = current.next
      end
      current.link marble
    end

    player = (player + 1) % players
  end

  scores.values.max
end

# p play(9, 25)    # 32h
# p play(10, 1618) # 8317
# p play(13, 7999) # 146373
# p play(17, 1104) # 2764
# p play(21, 6111) # 54718
# p play(30, 5807) # 37305

p "Part 1: #{play(468, 71010)}"
p "Part 2: #{play(468, 7101000)}"
