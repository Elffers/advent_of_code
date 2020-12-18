input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day18.in").split("\n").map { |x| x.delete(" ")}

# evaluates a complete expression within a single set of parens
def expression expr
  stack = []

  while !expr.empty?
    curr = expr.shift

    case curr
    when /(\d+)/
      stack << $1.to_i
    when "+"
      x = stack.pop
      y = expr.shift.to_i
      res = x + y
      stack << res
    when "*"
      x = stack.pop
      y = expr.shift.to_i
      res = x * y
      stack << res
    end
  end
  stack.first
end

def advanced_math expr
  stack = []

  while !expr.empty?
    curr = expr.shift
    case curr
    when /(\d+)/
      stack << $1
    when "+"
      x = stack.pop.to_i
      y = expr.shift.to_i
      stack << (x+y).to_s
    when "*"
      stack << curr
    end
  end
  expression(stack)
end

def calculate chars
  stack = []
  while !chars.empty?
    curr = chars.shift

    case curr
    when /(\d+)/
      stack << $1
    when /(\+|\*)/
      stack << curr # push operator onto stack
    when "("
      stack << curr
    when ")"
      expr = []
      while stack.last != "("
        x = stack.pop
        expr.unshift x
      end
      stack.pop # get rid of opening (
      # res = expression expr # part 1
      res = advanced_math expr

      stack.push res.to_s
    end

  end
  # expression(stack) # part 1
  advanced_math(stack)
end

p input.map { |line| calculate(line.chars) }.reduce(:+)
