input = File.read("/Users/hhhsu/sandbox/aoc/2023/inputs/day02.in").split("\n")
LIMITS = {
  "red" => 12,
  "green" => 13,
  "blue" => 14,
}

ids = (1..100).to_a
sum = 0
input.each.with_index do |line, i|
  id = i+1
  game = line.split(": ").last.split("; ")
  mins = Hash.new 0
  game.each do |move|
    cubes = move.split(", ")
    cubes.each do |cube|
      /(?<n>\d+) (?<color>\w+)/ =~ cube
      if LIMITS[color] < n.to_i
        ids.delete id
      end
      mins[color] = n.to_i if n.to_i > mins[color]
    end
  end
  sum += mins.values.reduce(:*)
end
p "Part 1: #{ids.sum}"
p "Part 2: #{sum}"
