input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day02.in").map { |x| x.strip }
x, y = 0, 0
input.each do |i|
  /(?<dir>\w+) (?<d>\d+)/ =~ i
  case dir
  when "forward"
    x += d.to_i
  when "down"
    y += d.to_i
  when "up"
    y -= d.to_i
  end
end

p x*y

