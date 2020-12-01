require 'set'
numbers = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day01.in").split("\n").map  {|x| x.to_i }
set = Set.new(numbers)
set.each do |n|
  complement = 2020-n
  if set.include? complement
    p n * complement
    break
  end
end

numbers.combination(3).each do |combo|
  if combo.reduce(:+) == 2020
    p combo.reduce(:*)
    break
  end
end

