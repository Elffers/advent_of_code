input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day18.in").split("\n").map { |x| x.delete(" ")}

# evaluates a complete expression within a single set of parens
def expression expr
  stack = []
  p "input: #{expr.join}"

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
  p "output: #{ stack}"
  stack.first
end

# %[a b]
def addition expr
  expr.first.to_i + expr.last.to_i
end

def advanced_math expr
  stack = []
  p "input: #{expr.join}"

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
  p chars.join
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
      res = advanced_math expr

      p "expr: #{expr}, stack before: #{stack.join}"
      stack.push res.to_s
      p "stack after: #{stack.join}"
    end

    p "stack: #{stack.join}"
  end
  res = advanced_math(stack)
  res
end

# line = "1 + 2 * 3 + 4 * 5 + 6"
# line = "1 + (2 * 3) + (4 * (5 + 6))"
line = "2 * 3 + (4 * 5)"

line = "5 + (8 * 3 + 9 + 3 * 4 * 3)"
p calculate(line.delete(" ").chars)
# line = "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))"
line = "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"

# p line
# p calculate(line.delete(" ").chars)

res = input.map { |line| calculate(line.chars) }.reduce(:+)
p "part 2: #{res}"
