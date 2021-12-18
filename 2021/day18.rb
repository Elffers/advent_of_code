require 'strscan'
input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day18test.in").split "\n"
# input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day18.in")
p input

class SF
  attr_accessor :nested_level

  def initialize val
    @val = val
    @level = init_level val
  end

  def init_level val
    if val.class == Integer
      0
    else
      1 + [init_level(val.first), init_level(val.last)].max
    end
  end

  def pair?
    val.class == Array
  end

  def num?
    val.class == Integer
  end

  def magnitude s
    if s.num?
      s.val
    else
      x = s.val.first
      y = s.val.last
      3*(magnitude x) + 2*(magnitude y)
    end
  end

  def explode?
    if nested_level == 5
      # find leftmost pair to explode
    end
  end

  def add s
    SF.new [val, s]
  end

  def reduce n
    actions = []
    # s = n.to_s
  end

  def split v
    n = v/2
    if v.odd?
      [n, n+1]
    else
      [n, n]
    end
  end
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

def add val, s
  [val, s]
end

def nested_level val
  if val.class == Integer
    0
  else
    1 + [nested_level(val.first), nested_level(val.last)].max
  end
end

def explode n
  # find leftmost pair to explode
  # x, y = find_pair n
  s = n.to_s
  /(\[.*\[.*\[.*\[*)\[(?<x>\d+),(?<y>\d+)\](\].*\].*\].*\]*)/ =~ s
  x, y = n
end

def split_num v
  n = v/2
  if v.odd?
    [n, n+1]
  else
    [n, n]
  end
end

def split s
  x, y = s
end


s = [[[[0,7],4],[[7,8],[6,0]]],[8,1]]
p "Part 1: #{magnitude s}"


s = [[[[[9,8],1],2],3],4]
p nested_level s
s = [[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]
p nested_level s
s = [[6,[5,[4,[3,2]]]],1]
p nested_level s

# p explode s
s = input.first
puts s
