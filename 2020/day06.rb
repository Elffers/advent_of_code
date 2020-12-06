input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day06.in").split("\n\n")

count1 = input.map do |group|
  group.dup.gsub("\n", "").chars.uniq.size
end.reduce(:+)

p "part 1: #{count1}"

count2 = 0
input.each do |group|
  answers = Hash.new 0

  members = group.split("\n")
  members.each do |m|
    m.each_char do |c|
      answers[c] += 1
    end
  end

  all_yes = 0
  answers.each do |answer, count|
    if count == members.size
      all_yes += 1
    end
  end

  count2 += all_yes
end

p "part 2: #{count2}"
