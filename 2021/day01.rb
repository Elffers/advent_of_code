depths = File.readlines("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day01.in").map { |x| x.strip.to_i }

pt1 = depths.each_cons(2).count { |(x,y)| y - x > 0 }
p "Part 1: #{pt1}"

pt2 = depths.each_cons(3).map { |x| x.sum }.each_cons(2).count { |(x,y)| y - x > 0 }
p "Part 2: #{pt2}"
