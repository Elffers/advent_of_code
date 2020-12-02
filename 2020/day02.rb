input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day02.in").map { |line| line.strip }
valid_count = 0
p2_count = 0

input.each do |line|
  /(?<min>\d+)-(?<max>\d+) (?<char>\w): (?<pwd>\w+)/ =~ line
  if pwd.count(char).between? min.to_i, max.to_i
    valid_count += 1
  end

  i = min.to_i - 1
  j = max.to_i - 1

  if (pwd[i] == char) ^ (pwd[j] == char)
    p2_count += 1
  end

end

p "Part 1: #{valid_count}"
p "Part 2: #{p2_count}"
