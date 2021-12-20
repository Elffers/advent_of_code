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

  # traverse tree in order - returns sequence of leaf values
  # this is to find left and right vals for explode addition
  # def inorder res, n
  #   n += 1
  #   if pair? && n == 5
  #     # p "FOUND IT: #{val}"
  #     res << val
  #   elsif leaf?
  #     res << val
  #   else
  #     left.inorder res, n
  #     right.inorder res, n
  #   end
  #   res
  # end
  def inorder seq, n
    n += 1
    p self.val
    if pair? && n == 5
      # p "FOUND IT: #{val}"
      seq << val
    elsif leaf?
      seq << val
    else
      left.inorder seq, n
      right.inorder seq, n
    end
    seq
  end

  # def traverse_split
  #   # p self.val
  #   if leaf? && val > 9
  #     self.val = split_val
  #     # insert
  #     return
  #   elsif leaf?
  #     return
  #   else
  #     left.traverse_split
  #     right.traverse_split
  #   end
  # end

  def magnitude
    if leaf?
      val
    else
      3*(left.magnitude) + 2*(right.magnitude)
    end
  end

  def add v
    Node.new [val, v]
  end

  # BFS to replace node
  def split
    queue = []
    queue << self
    while !queue.empty?
      curr = queue.shift
      if curr.leaf? && curr.val > 9
        curr.val = curr.split_val
        break
      else
        queue << curr.left
        queue << curr.right
      end
    end
  end

  def split_val
    n = val/2
    if val.odd?
      [n, n+1]
    else
      [n, n]
    end
  end

  # node must be a pair
  def explode node
    return if leaf?
    if explodable?
    end
    # traverse tree in-order to find the leaf nodes at level 4
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

def reduce n
end

s = [[[[[9,8],1],2],3],4]
# s = [[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]
# s = [[6,[5,[4,[3,2]]]],1]
# s = [[[[0,7],4],[[7,8],[6,0]]],[8,1]]

s = [[[[0,7],4],[15,[0,13]]],[1,1]]
root = build_tree(s)
p root.nested_level

puts "BEFORE SPLIT"
p "SEQ: #{root.inorder [], 0}"
root.split
puts "AFTER SPLIT"
# p root
p "SEQ: #{root.inorder [], 0}"
# explode s

# p "Part 1: #{root.magnitude}"
