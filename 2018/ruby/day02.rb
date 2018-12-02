input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day2.in").map { |x| x. strip }
twos = 0
threes = 0
# input = [
#   "abcdef",
#   "bababc",
#   "abbcde",
#   "abcccd",
#   "aabcdd",
#   "abcdee",
#   "ababab",
# ]

input.each do |x|
  counts = Hash.new 0

  x.chars.each do |char|
    counts[char] += 1
  end

  unique_counts = []
  counts.each do |char, count|
    unique_counts << count
  end
  unique_counts.uniq!

  twos += 1 if unique_counts.include? 2
  threes += 1 if unique_counts.include? 3
end

p twos * threes

# input = %w[
# abcde
# fghij
# klmno
# pqrst
# fguij
# axcye
# wvxyz
# ]

match = []
input.each do |x|
  input.each do |y|
    pairs = x.chars.zip(y.chars)
    diffs = pairs.select { |a, b| a != b }
    match = [x, y] if diffs.count == 1
  end
end

p match.first.chars.zip(match.last.chars).select  {|a, b| a == b }.map { |a, b| a }.join
