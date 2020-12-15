input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day15.in").split(",").map { |x| x.to_i }
input = [0,3, 6]

# holds each number and the last turn it was spoken
game = {}

turns = 0
input[0...input.size-1].each_with_index do |x, i|
  game[x] = i+1
  turns = i+1
end

last = input.last

while turns < 2020 #30_000_000
  turns += 1
  if game[last].nil?
    p "turn: #{turns} is #{last}"
    game[last] = turns
    last = 0
  else
    last_turn = game[last]
    p "turn: #{turns} is #{last}"
    game[last] = turns
    last = turns - last_turn
  end
  # p "game: #{game}"
end


