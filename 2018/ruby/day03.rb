input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day3.in")
# input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day3test.in")

claims = {}

input.map do |line|
  /(?<id>\d+) @ (?<x>\d+),(?<y>\d+): (?<w>\d+)x(?<l>\d+)/ =~ line
  claim = {
    x: x.to_i,
    y: y.to_i,
    width: w.to_i,
    length: l.to_i,
  }
  claims[id] = claim
end

cloth = Hash.new{ |h, k| h[k] = Hash.new { |m, n| m[n] = [] } }
overlaps = 0

claims.each do |id, claim|
  x, y, w, l = claim[:x], claim[:y], claim[:width], claim[:length]
  (x...x+w).each do |i|
    (y...y+l).each do |j|
      if !cloth[j][i].empty?
        cloth[j][i].each do |claim_id|
          claims[claim_id][:overlapped] = true
          claims[id][:overlapped] = true
        end
      end

      cloth[j][i] << id
    end
  end
end

cloth.each do |col, row|
  row.each do |pt, val|
    if val.size > 1
      overlaps += 1
    end
  end
end

p "Part 1: #{overlaps}"

claim_id, _ = claims.find do |id, claim|
  !claim[:overlapped]
end

p "Part 2: #{claim_id}"
