t, ids = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day13.in").split

t = t.to_i

buses = ids.split(",").select { |x| x != "x" }.map { |x| x.to_i }

departure_times = buses.map do |b|
  n = 1
  dt = n*b
  while n*b < t
    dt = n*b
    n += 1
  end

  dt += b
end

m = departure_times.min
idx = departure_times.index(m)
bus = buses[idx]
wait_time = m-t

p "part 1: #{wait_time * bus}"

# Part 2

buses = ids.split(",")
pairs = []
buses.each_with_index do |b, r|
  if b != "x"
    mod = b.to_i
    pairs << [mod, r]
  end
end

ts = 100000000000000 + 3 # this is divisible by 19

inc = 1
while !pairs.empty?
  b, i = pairs.shift
  loop do
    if (ts+i) % b == 0
      # increase increment by LCM of the current bus and next bus
      inc *= b
      break
    else
      ts += inc
    end
  end
end

p "part 2: #{ts}"
