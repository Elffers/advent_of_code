require 'digest'

class Maze
  attr_accessor :passcode, :maze, :md5

  def initialize passcode
    @passcode = passcode
    @maze = 4.times.map { '****'.chars }
    @md5 = Digest::MD5.new
    @dest = [3, 3]
  end

  def shortest_path
    queue = []
    current = Node.new [0, 0], ""
    queue << current

    paths = []

    while !queue.empty?
      current = queue.shift

      # return current.path if current.coords == @dest
      if current.coords == @dest
        paths << current.path.length
      else
        nodes = valid_moves current
        nodes.each do |node|
          queue << node
        end
      end
    end

    paths.last
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
    hash = md5.hexdigest(passcode + path)
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
