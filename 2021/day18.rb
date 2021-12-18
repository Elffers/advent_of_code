input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day18test.in")
input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day18.in")
# p input

class SF
  attr_accessor :level, :val
  def initialize val
    @val = val
  end

  def pair?
    val.class == Array
  end

  def num?
    val.class == Integer
  end
end


def add a, b
  [a, b]
end

def reduce a, f
end

def explode s
end

def split
end

def magnitude s
  if s.class == Integer
    s
  else
    x = s.first
    y = s.last
    3*(magnitude x) + 2*(magnitude y)
  end
end


p magnitude [[9,1],[1,9]]
