def play p1, p2, die, goal
  i = 0
  rolls = 0
  s1 = 0
  s2 = 0

  while s1 < goal && s2 < goal
    roll = []
    3.times do
      x = die.shift
      die << x
      roll << x
    end

    rolls += 3
    sum = roll.sum
    if i.even?
      p1 = (p1 + sum)
      while p1 > 10
        p1 -= 10
      end
      s1 += p1
      p "Player: 1"
      p "Score: #{s1}"
      p "space: #{p1}"
    else
      p2 = (p2 + sum)
      while p2 > 10
        p2 -= 10
      end
      s2 += p2
      p "Player: 2"
      p "Score: #{s2}"
      p "space: #{p2}"
    end
    i += 1
    puts
  end
  [s1, s2].min * rolls
end

p1 = 4
p2 = 8
# p1 = 3
# p2 = 5

die = (1..100).to_a
p "Part 1: #{ play p1, p2, die, 1000 }"
