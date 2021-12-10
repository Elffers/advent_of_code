input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day10test.in").split("\n")
input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day10.in").split("\n")
# p input

scores = {
  ")" => 3,
  "]" =>  57,
  "}" => 1197,
  ">" => 25137
}

match = {
  ")" => "(",
  "]" =>  "[",
  "}" => "{",
  ">" => "<",
  "(" => ")",
  "[" =>  "]",
  "{" => "}",
  "<" => ">"
}

def opener? c
  c == "(" || c == "[" || c == "{" || c == "<"
end

def closer? c
  c == ")" || c == "]" || c == "}" || c == ">"
end

score = 0
input.each do |l|
  stack = []
  cs = l.chars
  cs.each_with_index do |c, i|
    if opener? c
      stack << c
    elsif closer? c
      x = stack.last
      if (match[c] == x)
        stack.pop
      else
        score += scores[c]
        break
      end
    end
  end
end
p "Part 1: #{score}"
