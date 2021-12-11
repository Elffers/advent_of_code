input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day11test.in").split("\n")
input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day11test2.in").split("\n")
# input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day11.in").split("\n")

@h = input.size
@w = input.first.size

# os = input.map { |l| l.chars.map { |x| x.to_i }}
#

def neighbors x, y
  dirs = [
  [-1, -1], [-1, 0], [-1, 1],
  [ 0, -1],          [ 0, 1],
  [ 1, -1], [ 1, 0], [ 1, 1],
]
dirs.map do |(i,j)|
  dx, dy = x+i, y+j
  if (0 <= dx  && dx < @h) && (0 <= dy && dy < @w)
    [dx, dy]
  end
   end
end

# everyone increases by 1
def inc octs
  octs.map do |line|
    line.map do |n|
      n + 1
    end
  end
end

def flash os
  flashes = 0
  fs = os.dup
  # anyone > 9 increases all neighbors by 1
  os.each_with_index do |line, x|
    line.each_with_index do |o, y|
      if o > 9
        ns = neighbors x, y
        ns.each do |(i,j)|
          fs[i][j] += 1
        end
        #need to find out how much to increment this thing by based on cascading
        # queue = ns
        # while !queue.empty?
        #   n = queue.shift # coordinates
        #   i, j = n.first, n.last
        #   fs[i][j] += 1
        #   if fs[i][j] > 9
        #     # fs[i][j] =0
        #     queue.concat neighbors(i,j)
        #   end
        # end
      end
    end
  end

  xs = fs.dup
  fs.each_with_index do |line, x|
    line.each_with_index do |p, y|
      if p > 9
        xs[x][y] = 0
        flashes += 1
      end
    end
  end

  p "FLASH"
  xs.each { |o| p o}
  puts

  [xs, flashes]
end


flashes = 0
octs = input.map { |x| x.chars.map { |c| c.to_i }}
10.times do
  os = inc octs
  os.each { |o| p o}
  puts
  octs, f  = flash os
  flashes += f
end

p "Part 1: #{flashes}"
