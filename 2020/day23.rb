cups = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day23.in").strip.chars.map { |x| x.to_i }
# cups = "389125467".chars.map { |x| x.to_i }

def move cups
  curr = cups.first

  pickup = cups[1..3]
  rest = cups[4..-1]

  if curr == cups.min
    dest = rest.max
  else
    dest = curr - 1
    while pickup.include? dest
      if dest < rest.min
        dest = rest.max
      else
        dest -= 1
      end
    end
  end

  p "curr: #{curr}"
  p "dest: #{dest}"
  p cups

  idx = rest.index(dest) + 1
  new = rest.rotate idx

  new.concat pickup
  new.rotate!(-(idx+3))

  new << curr
  p "new: #{new}"
  puts

  new
end

100.times do
  cups = move cups
end

def final cups
  i = cups.index 1
  post = cups[(i+1)..-1]
  pre = cups[0...i]
  post.concat(pre).join
end

p "part 1: #{final cups}
