input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day18test.in").split "\n"
# input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day18.in").split "\n"

class Node
  attr_accessor :left, :right, :val, :parent

  def initialize  val # parent=nil
    @val = val
    # @parent = parent
  end

  def leaf?
    val.class == Integer
  end

  def pair?
    val.class == Array &&
      left.leaf? &&
      right.leaf?
  end

  def nested_level
    if val.class == Integer
      0
    else
      1 + [left.nested_level, right.nested_level].max
    end
  end

  def explodable?
    nested_level == 5
  end

  # this is to find left and right vals for explode
  def inorder res, n
    n += 1
    if self.pair? && n == 5
      # p "FOUND IT: #{val}"
      res << val
    elsif self.leaf?
      res << val
    else
      left.inorder res, n
      right.inorder res, n
    end
    res
  end

  def magnitude
    if leaf?
      val
    else
      3*(left.magnitude) + 2*(right.magnitude)
    end
  end

end

# build tree from given snailfish string
def build_tree v
  root = Node.new v
  return root if root.leaf?
  left_v = v.first
  right_v = v.last
  root.left = build_tree left_v
  root.right = build_tree right_v

  root
end

# node must be a pair
def explode node
  return if leaf? node
  # traverse tree in-order to find the leaf nodes at level 4
end

def add val, s
  [val, s]
end

def reduce n
end

def split v
  n = v/2
  if v.odd?
    [n, n+1]
  else
    [n, n]
  end
end

s = [[[[[9,8],1],2],3],4]
s = [[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]
s = [[6,[5,[4,[3,2]]]],1]
# s = [[[[0,7],4],[[7,8],[6,0]]],[8,1]]

root = build_tree(s)
p root.inorder [], 0
p root.nested_level
# explode s

p "Part 1: #{root.magnitude}"

