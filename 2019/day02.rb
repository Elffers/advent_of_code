input = File.read("./inputs/day02.in").strip

def process input
  input.split(",").map { |x| x.to_i }
end

input = process input

input[1] = 12
input[2] = 2

def run input
  index = 0
  while input[index] != 99
    idx1 = input[index + 1]
    idx2 = input[index + 2]
    store = input[index + 3]

    val = 0
    opcode = input[index]

    case opcode
    when 1
      val = input[idx1] + input[idx2]
    when 2
      val = input[idx1] * input[idx2]
    end

    input[store] = val
    index += 4
  end

  input
end

run input
p "Part 1: #{input[0]}"
