input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day08.in").split("\n")

def analyze digits, output
  res = Array.new 10
  digits.each do |d|
    case d.length
    when 2
      res[1] = d
    when 3
      res[7] = d
    when 4
      res[4] = d
    when 7
      res[8] = d
    end
  end

  digits.each do |d|
    case d.length
    when 5
      # if it contains everything in 1, then we know it's 3
      if res[1].chars.all? { |x| d.chars.include? x }
        res[3] = d
      end
    when 6
      # if it contains everyting in 4, we know it is 9
      if res[4].chars.all? { |x| d.chars.include? x }
        res[9] = d
      end
    end
  end

  digits.each do |d|
    case d.length
    when 5
      # difference between 9 and 2 is 2 characters; for the other length 5
      # options there's only a 1 char difference
      if (res[9].chars - d.chars).length == 2
        res[2] = d
      end
    when 6
      # if it contains everything in 7, we know it is 0 AFTER we figure out 9
      if res[7].chars.all? { |x| d.chars.include? x } && d != res[9]
        res[0] = d
      end
    end
  end

  digits.each do |d|
    if d.length == 5 && d != res[2] && d != res[3]
      res[5] = d
    elsif d.length == 6 && d != res[9] && d != res[0]
      res[6] = d
    end
  end

  res = res.map { |x| x.chars.sort }
  display = output.map do |d|
    d = d.chars.sort
    res.find_index d
  end

  display.join.to_i
end

count = 0
sum = 0
input.each do |line|
  l = line.split(" | ")
  digits, output = [l.first, l.last].map { |x| x.split(" ") }
  sum += analyze digits, output

  c = output.select { |x| x.length == 2 || x.length == 4 || x.length == 3 || x.length == 7 }
  count += c.size
end

p "Part 1: #{count}"
p "Part 2: #{sum}"
