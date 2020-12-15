input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day15.in").split(",").map { |x| x.to_i }

# holds each number and the last turn it was spoken
game = {}

turns = 0
input[0...input.size-1].each_with_index do |x, i|
  game[x] = i+1
  turns = i+1
end

last = input.last

loop do
  turns += 1
  if game[last].nil?
    game[last] = turns
    last = 0
  else
    last_turn = game[last]
    game[last] = turns
    last = turns - last_turn
  end

  if turns == 2020-1
     p "part 1: #{last}"
  end
  if turns == 30000000-1
     p "part 2: #{last}"
     break
  end
end
