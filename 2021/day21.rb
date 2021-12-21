def play p1, p2, die, goal
  i = 0
  rolls = 0
  s1 = 0
  s2 = 0

  while s1 < goal && s2 < goal
    sum = 0
    3.times do
      sum += die.first
      die = die.rotate
    end

    rolls += 3
    if i.even?
      p1 = (p1 + sum)
      while p1 > 10
        p1 -= 10
      end
      s1 += p1
    else
      p2 = (p2 + sum)
      while p2 > 10
        p2 -= 10
      end
      s2 += p2
    end
    i += 1
  end
  [s1, s2, rolls]
end

p1 = 4
p2 = 8
# p1 = 3
# p2 = 5

die = (1..100).to_a
s1, s2, rolls =  play p1, p2, die, 1000
p "Part 1: #{[s1,s2].min * rolls}"

@paths = []

class Node
  attr_accessor :children, :val, :path, :parent

  def initialize val, parent, path=[]
    @val = val
    @parent = parent
    @children = []
  end

  def path
    path = []
    up = parent
    while up
      path.unshift up.val
      up = up.parent
    end
    path
  end

end

# generate tree
def split node
  die = [1,2,3]
  die.each do |val|
    n = Node.new val, node
    node.children << n
  end
  node.children
end

def build_quantum_tree
  die = [1,2,3]
  nodes = die.map do |val|
    n = Node.new val, nil
  end
  n = 0
  queue = []
  queue.concat nodes
  while n < 500_000
    node = queue.shift
    children = split node
    queue.concat children
    # p queue.size
    n += 1
  end
  nodes
end

@paths = []
def find_paths node, path, plen
  return if node. nil?
  if path.size > plen
    path[plen] = node.val
  else
    path << node.val
  end
  plen += 1

  if node.children.empty?
    @paths << path
    return path
  else
    path << node.val
    find_paths node.children[0], path, plen
    find_paths node.children[1], path, plen
    find_paths node.children[2], path, plen
  end
end

nodes = build_quantum_tree
nodes.each do |node|
  find_paths node, [], 0
end
p @paths.size

c1 = 0
c2 = 0
@paths.each do |die|
 s1, s2, _ = play p1, p2, die, 8
 if s1 > s2
   c1 += 1
 else
   c2 += 2
 end
end
p c1, c2
