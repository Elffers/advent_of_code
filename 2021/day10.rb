input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day10.in").split("\n")

scores = {
  ")" => 3,
  "]" => 57,
  "}" => 1197,
  ">" => 25137
}
ac = {
  "(" => 1,
  "[" => 2,
  "{" => 3,
  "<" => 4
}
match = {
  ")" => "(",
  "]" => "[",
  "}" => "{",
  ">" => "<",
}

def opener? c
  c == "(" || c == "[" || c == "{" || c == "<"
end

def closer? c
  c == ")" || c == "]" || c == "}" || c == ">"
end

score = 0
stacks = []
input.each do |l|
  incomplete = true
  stack = []
  l.chars.each do |c|
    if opener? c
      stack << c
    elsif closer? c
      if match[c] == stack.last
        stack.pop
      else
        incomplete = false
        score += scores[c]
        break
      end
    end
  end
  stacks << stack if incomplete
end
p "Part 1: #{score}"

ac_scores = stacks.map do |stack|
  ac_score = 0
  stack.reverse.each do |c|
    ac_score = ac_score * 5 + ac[c]
  end
  ac_score
end
p "Part 2: #{ac_scores.sort[ac_scores.length/2]}"
