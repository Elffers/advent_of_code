input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day18test.in").split "\n"
# input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day18.in").split "\n"
#
class Node
  def initialize
  end

end

def leaf? n
  n.class == Integer
end

def pair? s
  s.class == Array &&
    s.first.class == Integer &&
    s.last.class == Integer
end

def inorder node, n, res
  n+=1
  if (pair? node) && n == 5
    p "FOUND IT: #{node}"
    res << node
  elsif leaf? node
    res << node
  else
    inorder(node.first, n, res)
    inorder(node.last, n, res)
  end
  res
end


# node must be a pair
def explode node
  return if leaf? node

  # traverse tree in-order to find the leaf nodes at level 4
  layer = []
  layer << node
  left = nil
  right = nil
  n = 0
  levels = { node => n }

  while !layer.empty?
    n += 1
    next_layer = []
    layer.each do |node|
      if n == 5 && pair?(node)
        p "FOUND IT: #{node}"
        p [left, right]
        # do the thing
      end
      if !leaf? node
        x = node.first
        y = node.last
        if leaf? x
          left = [x, n]
        end
        if leaf? y
          right = [y, n]
        end
        next_layer << x
        next_layer << y
        levels[node] = n
      end
      layer = next_layer
    end
    p "LEVEL: #{n}"
    puts
  end
end

def add s
  [val, s]
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

# def explode n
#   # find leftmost pair to explode
#   # x, y = find_pair n
#   s = n.to_s
#   /(\[.*\[.*\[.*\[*)\[(?<x>\d+),(?<y>\d+)\](\].*\].*\].*\]*)/ =~ s
#   x, y = n
# end

def split_num v
  n = v/2
  if v.odd?
    [n, n+1]
  else
    [n, n]
  end
end

s = [[[[0,7],4],[[7,8],[6,0]]],[8,1]]
# p "Part 1: #{magnitude s}"

s = [[[[[9,8],1],2],3],4]
# explode s
p inorder s, 0, []
# s = [[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]
# p inorder s, 0, []

s = [[6,[5,[4,[3,2]]]],1]
p inorder s, 0, []
