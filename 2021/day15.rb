input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day15test.in").split("\n").map { |x| x.chars.map { |c| c.to_i }}

# vertical and horizontal only
def adj x, y, h, w
  ns = []
  [ [-1, 0], [1, 0], [0, -1], [0, 1] ].each do |i, j|
    dx, dy = x+i, y+j
    if (0 <= dx && dx < h) && (0 <= dy && dy < w)
      ns << [dx, dy]
    end
  end
  ns
end

# only works if neighbors are down and right
# def shortest_path input
#   h = input.size
#   w = input.first.size
#   memo = Array.new(h) { Array.new w }
#   memo[0][0] = 0
#   (0...w).each do |j|
#     next if j == 0
#     memo[0][j] = memo[0][j-1] + input[0][j]
#   end
#   (0...h).each do |i|
#     next if i == 0
#     memo[i][0] = memo[i-1][0] + input[i][0]
#   end

#   (1...h).each do |i|
#     (1...w).each do |j|
#       ns = adj i, j, input
#       v = ns.map { |(x, y)| memo[x][y] }
#       memo[i][j] = input[i][j] + v.compact.min
#     end
#   end
#   memo[h-1][w-1]
# end

def inc input, i
  x = (1..9).to_a
  input.map do |r|
    x = (r+i) %9
    if x == 0
      x = 9
    end
    x
  end
end

def expand input
  res = []
  i = 0
  while i < 5
  input.each do |row|
    new_row = []
    (0..4).each do |j|
      new_row.concat(inc row, i+j)
    end
    res << new_row
  end
  i += 1
  end
  res
end


def dijkstra weights
  h = weights.size
  w = weights.first.size

  dist = Hash.new {|h, k| h[k] = Float::INFINITY }

  s = [0,0]
  dist[s] = 0
  queue = [s]

  while u = queue.shift
    x, y = u
    vs = adj x, y, h, w
    delta = dist[[y,x]] # TODO

    vs.each do |i, j|
      d = weights[j][i]
      cost = delta + d
      if cost < dist[[j,i]]
        dist[[j,i]] = cost # decrease-key
        queue << [i,j]
      end
    end
  end

  dist[[h-1,w-1]]
end

p "Part 1: #{dijkstra input}"
p "Part 2: #{dijkstra(expand input)}"
