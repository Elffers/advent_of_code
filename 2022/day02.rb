input = File.read("/Users/hhhsu/sandbox/aoc/2022/inputs/day02.in").split("\n")

# %w[Rock Paper Scissors]
PLAYS = %w[A B C]
STRATEGY = %w[X Y Z]

MOD = PLAYS.length

POINTS = {
  "A" => 1, # Rock
  "B" => 2, # Paper
  "C" => 3, # Scissors
}

OUTCOMES = {
  "X" => 0, # loss
  "Y" => 3, # draw
  "Z" => 6, # win
}

# you win if your play is to the right of the element of your opponent in the
# array
def win?(opp, strategy)
  i = PLAYS.index opp
  j = STRATEGY.index strategy

  (i + 1) % MOD == j
end

def draw?(opp, strategy)
  i = PLAYS.index opp
  j = STRATEGY.index strategy

  i == j
end

def outcome(opp, strategy)
  if draw?(opp, strategy)
    OUTCOMES["Y"]
  elsif win?(opp, strategy)
    OUTCOMES["Z"]
  else # loss
    OUTCOMES["X"]
  end
end

def pick_play(opp, strategy)
  i = PLAYS.index opp
  j = case strategy
  when "Z" # win
    (i + 1) % MOD
  when "Y" # draw
    i
  when "X" # lose
    (i - 1) % MOD
  end

  PLAYS[j]
end

def convert(strategy)
  i = STRATEGY.index(strategy)
  PLAYS[i]
end

def score(opp, strategy)
  shape = convert(strategy)
  outcome(opp, strategy) + POINTS[shape]
end

def score2(opp, strategy)
  shape = pick_play(opp, strategy)
  OUTCOMES[strategy] + POINTS[shape]
end

pts = 0
pts2 = 0

input.each do |play|
  opp, strategy = play.split(" ")
  pts += score(opp, strategy)
  pts2 += score2(opp, strategy)
end

p "Part 1: #{pts}"
p "Part 2: #{pts2}"
