input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day14.in")
input = "084601"
# input = "59414"
target = input.chars.map { |x| x.to_i }
# input = "59414"

scores = {
  0 => 3,
  1 => 7
}

i1, i2 = 0, 1
i = 2 # next index

n = input.to_i
loop do
  r1, r2 = scores[i1], scores[i2]
  r = r1+r2
  a = r/10
  b = r % 10

  if a != 0
    scores[i] = a

    i += 1 # increment index
    j = i - target.size
    pattern = (j...j + target.size).map do |idx|
      scores[idx].to_s
    end.join
    if pattern == input
      p "Part 2: #{j}"
      break
    end
  end

  scores[i] = b
  i += 1
  j = i - target.size
  pattern = (j...j + target.size).map do |idx|
    scores[idx].to_s
  end.join
  if pattern == input
      p "Part 2: #{j}"
    break
  end

  i1 = (r1 + i1 + 1) % scores.size
  i2 = (r2 + i2 + 1) % scores.size

  if scores.size == n+10
    pattern = (n..n+9).map do |idx|
      scores[idx].to_s
    end.join

    p "Part 1: #{pattern}"
  end
end
