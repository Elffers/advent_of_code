input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day15.in").split(",").map { |x| x.to_i }
# input = [0,3,6]

def run input, n
  # holds each number and the last turn it was spoken
  last_turn = {}

  # populate map with everything in input except last element
  input[0...input.size-1].each_with_index do |x, i|
    last_turn[x] = i+1
  end

  curr = input.last
  turn = input.size

  while turn < n
    if last_turn[curr].nil?
      last_turn[curr] = turn
      curr = 0
    else
      prev = last_turn[curr]
      last_turn[curr] = turn
      curr = turn - prev
    end
    turn += 1
  end

  curr
end


res = run input, 2020
p "part 1: #{res}"

res = run input, 30000000
p "part 2: #{res}"

