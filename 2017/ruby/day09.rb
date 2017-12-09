input = File.read('../day9.in').strip
$groups = ""

chars = input.chars

# remove all garbage
def parse chars
  count = 0
  while !chars.empty?
    char = chars.shift
    case char
    when "<"
      g = chars.shift
      while g != ">"
        if g == "!"
          chars.shift
        end

        if !"!>".include? g
          count += 1
        end

        g = chars.shift
      end
    else
      $groups += char
    end
  end
  count
end

p parse chars

def score groups
  stack = []
  chars = groups.chars
  score = 0

  while !chars.empty?
    char = chars.shift
    case char
    when "{" # start group
      stack.push char
    when "}"
      score += stack.size
      stack.pop
    end
  end
  score
end

p score $groups
