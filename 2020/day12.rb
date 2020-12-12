input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day12.in").split("\n")
input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day12test.in").split("\n")

east = [1,0]
south = [0,-1]
west = [-1,0]
north = [0,1]

@dirs = [east, south, west, north]

@dir = 0

def facing
  @dirs[@dir]
end

start = [0,0]
pos = start

input.each do |i|
  /(?<dir>\w)(?<n>\d+)/ =~ i
  n = n.to_i

  move = [0, 0]
  case dir
  when "N"
    move = north.map { |x| x*n }
  when "S"
    move = south.map { |x| x*n }
  when "E"
    move = east.map { |x| x*n }
  when "W"
    move = west.map { |x| x*n }
  when "F"
    move = facing.map { |x| x*n }
  when "L"
    @dir = (@dir - n/90) % 4
    p "turned left: #{@dir}"
  when "R"
    @dir = (@dir + n/90) % 4
    p "turned right: #{@dir}"
  end

  pos = [pos[0]+move[0], pos[1]+move[1]]
end

p pos.map { |x| x.abs }.sum
