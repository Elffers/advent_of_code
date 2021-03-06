require 'digest'

class Maze

  def initialize passcode
    @passcode = passcode
  end

  def shortest_path
    queue = []
    current = Node.new [0, 0], ""
    queue << current

    paths = []

    while !queue.empty?
      current = queue.shift

      if current.coords == [3, 3]
        p current.path if paths.empty? # part 1
        paths << current.path.length
      else
        nodes = valid_moves current
        nodes.each do |node|
          queue << node
        end
      end
    end

    paths.last # part 2
  end

  def valid_moves node
    x, y = node.coords

    nodes = [
      Node.new([x-1, y], node.path + "U"),
      Node.new([x+1, y], node.path + "D"),
      Node.new([x, y-1], node.path + "L"),
      Node.new([x, y+1], node.path + "R")
    ]
    codes = door_codes node.path

    valid_nodes nodes, codes
  end

  def door_codes path
    md5 = Digest::MD5.new
    hash = md5.hexdigest(@passcode + path)
    hash[0,4].chars
  end

  def valid_nodes nodes, codes
    nodes.select.with_index do |node, i|
      open? node, codes[i]
    end
  end

  def open? node, code
    x, y = node.coords

    (/[b-f]/ =~ code) &&
      x >= 0 && x < 4 &&
      y >= 0 && y < 4
  end

end

class Node
  attr_accessor :coords, :path
  def initialize coords, path
    @coords = coords
    @path = path
  end
end

if __FILE__ == $0
  input = "rrrbmfta"
  m = Maze.new input
  p m.shortest_path
end
