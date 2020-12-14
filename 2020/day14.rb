input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day14.in").split("\n")

mem = Hash.new 0
mem2 = Hash.new 0

mask = "0" * 36
input.each do |x|
  instr, val = x.split(" = ")
  if instr == "mask"
    mask = val
  else
    /mem\[(?<addr>\d+)\]/ =~ instr
    val = ("%036b" % val.to_i).chars.zip(mask.chars).map do |b, m|
      if m == "X"
        b
      else
        m
      end
    end.join.to_i(2)

    mem[addr] = val
  end
end

p "part 1: #{mem.values.sum}"
