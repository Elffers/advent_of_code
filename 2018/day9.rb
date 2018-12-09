def play(players, last_marble)
  i = 0
  current = 0
  player = 0
  circle = []
  circle[i] = current

  scores = Hash.new 0

  while current <= last_marble
    i = (i + 1) % (circle.size) + 1

    current += 1

    if current % 23 == 0 && current != 0
      scores[player] += current
      remove_at = (i - 9) % circle.size
      marble = circle.delete_at(remove_at)
      scores[player] += marble
      i = (remove_at) % circle.size
    else
      circle.insert(i, current)
    end

    player = (player + 1) % players
  end

  # p scores
  scores.values.max
end

p play(9, 25) # 32
# p play(10, 1618) # 8317
# p play(13, 7999) # 146373
# p play(17, 1104)  #2764
# p play(21, 6111)  #54718
# p play(30, 5807)  #37305
p "Part 1: #{play(468, 71010)}"
