input = File.read("/Users/hhhsu/sandbox/aoc/2022/inputs/day10.in").split("\n")

x = 1
cycle = 0
ss = nil

sum = 0
cycles = [20, 60, 100, 140, 180, 220]
i = 0

screen = Array.new(240) { |i| " " }

def display screen
  screen.each_slice(40) do |row|
    puts row.join
  end
end

def exec x, cycle, screen
  sprite = [x-1, x, x+1]
  pixel = (cycle % 40)
  if sprite.include? pixel
    screen[cycle] = "#"
  end
  cycle += 1
  [cycle, cycle*x]
end

input.each do |line|
  instr, n = line.split(" ")
  case instr
  when "noop"
    cycle, ss = exec(x, cycle, screen)
    if cycle == cycles[i]
      sum += ss
      i += 1
    end
  when "addx"
    2.times do
    cycle, ss = exec(x, cycle, screen)
      if cycle == cycles[i]
        sum += ss
        i += 1
      end
    end
    x += n.to_i
  end
end

p "Part 1: #{sum}"
display screen
