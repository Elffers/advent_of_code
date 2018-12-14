input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day14.in")
input = "084601"

input = "59414"
scores = %w[3 7]
i1, i2 = 0, 1

n = input.to_i
current = 0
loop do
  r1, r2 = scores[i1].to_i, scores[i2].to_i
  r = r1+r2

  score = r.to_s.chars
  scores.concat score

  pattern = (current...current + input.size).map do |i|
    scores[i]
  end.join
  # p pattern
  if pattern == input
    p "Part 2: #{current}"
    break
  else
    current += 1
  end


  # if scores.join.include? input
  #   p "found it"
  # end

  i1 = (r1 + i1 + 1) % scores.size
  i2 = (r2 + i2 + 1) % scores.size

  if scores.size == n+10
    p "Part 1: #{scores[n,n+9].join}"
    # break
  end
end
