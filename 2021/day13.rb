input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day13test.in").split "\n\n"
input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day13.in").split "\n\n"

lines = input.first.split "\n"
instr = input.last.split("\n").map do |i|
  /(?<axis>\w)=(?<n>\d+)/ =~ i
  [axis, n.to_i]
end
i = instr.first
i1 = instr[1]
# p instr

cds = lines.map do |line|
  line.split(",").map { |x| x.to_i }
end

def display grid
  grid.each do |l|
    row = l.map do |p|
      if p.nil?
        "."
      else
        "#"
      end
    end
    puts row.join
  end
end

def grid cds
  w = cds.map { |x| x.first }.max
  h = cds.map { |x| x.last }.max
  g = Array.new(h+1) { Array.new(w+1) }
  cds.each do |(i, j)|
    g[j][i] = "#"
  end
  g
end

g = grid cds
# display g
puts

def fold g, i
  # w = cds.map { |x| x.first }.max
  # h = cds.map { |x| x.last }.max
  axis, n = i
  count = 0

  case axis
  when "y"
    h = g.size
    w = g.first.size
    # w is the same
    # folded = Array.new(h-n) { Array.new(w+1) }
    # rows 0 through n-1 will be the same
    # rows n through h will be upside down
    top = g[0,n-1]
    bottom = g[n,h].reverse
    display(bottom)
    if n >= h/2
      (0..n-1).each do |i|
        row = g[i]
        if i >= n-(h-n)
          j = n+(n-i)
          overlap = g[j]
          row.zip(overlap).each do |x|
            if x.include? "#"
              count += 1
            end
          end
        else
          count += row.count "#"
        end
      end
    else
      # size of bottom = h-n, so indexes = 0 - (n+2)
      # size of top = n
      bottom.each_with_index do |row, i|
        if i <= bottom.size - n
          j = n-(n-i)
          overlap = g[j]
          row.zip(overlap).each do |x|
            if x.include? "#"
              count += 1
            end
          end
        else
          count += row.count "#"
        end
      end
    end
  when "x"
    #   # h is the same
    #   grid = Array.new(h) { Array.new(w-n) }
    # end
    g = g.transpose
    h = g.size
    if n >= h/2
      (0..n-1).each do |i|
        row = g[i]
        if i >= n-(h-n)
          j = n+(n-i)
          overlap = g[j]
          row.zip(overlap).each do |x|
            if x.include? "#"
              count += 1
            end
          end
        else
          count += row.count "#"
        end
      end
    else
      # size of bottom = h-n, so indexes = 0 - (n+2)
      # size of top = n
      bottom.each_with_index do |row, i|
        if i <= bottom.size - n
          j = n-(n-i)
          overlap = g[j]
          row.zip(overlap).each do |x|
            if x.include? "#"
              count += 1
            end
          end
        else
          count += row.count "#"
        end
      end
    end

  end
  p count
  # need to return grid
  count
end

g = grid(cds)
p fold(g, i)
# display(fold(cds, i))
