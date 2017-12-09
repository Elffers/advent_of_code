input = File.read('../day9.in').strip

chars = input.chars

def parse chars
  # part 1
  score       = 0
  stack_depth = 0

  # part 2
  count = 0

  while !chars.empty?
    char = chars.shift
    case char

    when "{" # start group
      stack_depth += 1
    when "}"
      score += stack_depth
      stack_depth -= 1
    when "<"  # deal with garbage
      g = chars.shift

      while g != ">"
        if g == "!"
          chars.shift
        end

        # count garbage characters
        if !"!>".include? g
          count += 1
        end
        g = chars.shift
      end

    end
  end

  [score, count]
end

p parse chars
