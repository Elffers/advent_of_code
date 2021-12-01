input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day01.in")
depths = input.map { |x| x.strip.to_i }

count = depths.each_cons(2).count { |(x,y)| y - x > 0 }
p count
