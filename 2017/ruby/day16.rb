input = File.read("../day16.in").strip.split(',')
dancers = ("a".."p").to_a
n = 0
seen = []

while n < 1_000_000_000
  input.each do |instr|
    move, args = instr[0], instr[1..-1]
    case move
    when "s"
      dancers.rotate!(-args.to_i)
    when "x"
      pos1, pos2 = args.split("/").map { |x| x.to_i }
      arg1 = dancers[pos1]
      arg2 = dancers[pos2]
      dancers[pos1] = arg2
      dancers[pos2] = arg1
    when "p"
      arg1, arg2 = args.split("/")
      pos1 = dancers.index arg1
      pos2 = dancers.index arg2
      dancers[pos1] = arg2
      dancers[pos2] = arg1
    end
  end

  if seen.include? dancers.join
    index = 1_000_000_000 % n - 1
    p "part 2: #{seen[index]}"
    break
  else
    seen.push(dancers.join)
  end

  n += 1
end

p "part 1: #{dancers.join}"
