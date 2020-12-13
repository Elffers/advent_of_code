t, ids = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day13.in").split

t = t.to_i

buses = ids.split(",").select { |x| x != "x" }.map { |x| x.to_i}
p buses

x = buses.map do |b|
  n = 1
  dep = n*b
  while n*b < t
    dep = n*b
    n += 1
  end
  dep += b
end

m = x.min
i = x.index(m)
bus = buses[i]
delta = m-t

p "part 1: #{delta * bus}"
