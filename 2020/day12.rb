input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day12.in").split("\n")
# input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day12test.in").split("\n")

east = [1,0]
south = [0,-1]
west = [-1,0]
north = [0,1]

@dirs = [east, south, west, north]

@dir = 0

def facing
  @dirs[@dir]
end

pos = [0,0]

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
  when "R"
    @dir = (@dir + n/90) % 4
  end
  pos = [pos[0]+move[0], pos[1]+move[1]]
end

p "part 1: #{pos.map { |x| x.abs }.sum}"

pos = [0,0]
waypoint = [10,1]

input.each do |i|
  /(?<dir>\w)(?<n>\d+)/ =~ i
  n = n.to_i

  case dir
  when "N"
    move = north.map { |x| x*n }
    waypoint = [waypoint[0]+move[0], waypoint[1]+move[1]]
  when "S"
    move = south.map { |x| x*n }
    waypoint = [waypoint[0]+move[0], waypoint[1]+move[1]]
  when "E"
    move = east.map { |x| x*n }
    waypoint = [waypoint[0]+move[0], waypoint[1]+move[1]]
  when "W"
    move = west.map { |x| x*n }
    waypoint = [waypoint[0]+move[0], waypoint[1]+move[1]]
  when "F"
    move = waypoint.map { |x| x*n }
    pos = [pos[0]+move[0], pos[1]+move[1]]
  when "R"
    rot = n/90
    x, y = waypoint
    rot.times do
      x, y = y, -x
    end
    waypoint = [x, y]
    p "turned right: #{waypoint}"
  when "L"
    rot = n/90
    x, y = waypoint
    rot.times do
      x, y = -y, x
    end
    waypoint = [x, y]
    p "turned left: #{waypoint}"
  end

end

p "part 2: #{pos.map { |x| x.abs }.sum}"
