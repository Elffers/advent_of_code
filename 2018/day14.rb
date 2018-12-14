input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day14.in")
input = 84601

scores = [3,7]
i1, i2 = 0, 1

n = input
loop do
  r1, r2 = scores[i1], scores[i2]
  r = r1+r2
  score = r.to_s.chars.map { |x| x.to_i }
  scores.concat score
  # p scores

  i1 = (r1 + i1 + 1) % scores.size
  i2 = (r2 + i2 + 1) % scores.size

  if scores.size == n+10
    p "Part 1: #{scores[n,n+9].map { |x| x.to_s }.join}"
    break
  end
end
