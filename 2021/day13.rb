input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day13.in").split "\n\n"

lines = input.first.split "\n"
instr = input.last.split("\n").map do |i|
  /(?<axis>\w)=(?<n>\d+)/ =~ i
  [axis, n.to_i]
end

cds = lines.map do |line|
  line.split(",").map { |x| x.to_i }
end

def display grid
  grid.each do |l|
    row = l.map do |p|
      p.nil? ? " " : "#"
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

def fold_helper g, n
  h = g.size
  w = g.first.size
  count = 0

  # rows 0-(n-1) will be the same
  # rows n-h will be upside down
  top = g[0...n]
  bottom = g[n+1..h].reverse
  new_height = [top.size, bottom.size].max
  folded = Array.new(new_height) { Array.new(w) }

  if top.size >= bottom.size
    (0...n).each do |i|
      row = g[i]
      # check for overlapping dots
      if i >= n-(h-n)
        j = n+(n-i)
        overlap = g[j]
        nr = row.zip(overlap).map do |x|
          if x.include? "#"
            count += 1
            "#"
          else
            nil
          end
        end
        folded[i] = nr
      else
        count += row.count "#"
        folded[i] = row
      end
    end
  else
    bottom.each_with_index do |row, i|
      if i <= bottom.size - n
        j = n-(n-i)
        overlap = g[j]
        nr = row.zip(overlap).map do |x|
          if x.include? "#"
            count += 1
            "#"
          else
            nil
          end
        end
        folded[i] = nr
      else
        count += row.count "#"
        folded[i] = row
      end
    end
  end
  p "COUNT: #{count}"
  folded
end

def fold g, instr
  axis, n = instr
  folded = nil

  folded = case axis
  when "y"
    fold_helper g, n
  when "x"
    f = fold_helper g.transpose, n
    f.transpose
  end
  folded
end

g = grid(cds)

instr.each do |i|
  g = fold(g, i)
  display g
end
