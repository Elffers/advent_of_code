input = File.read("/Users/hhhsu/sandbox/advent_of_code/2023/inputs/day09.in").split("\n")

seqs = input.map { |x| x.split(" ").map { |n| n.to_i } }

def find_next seq
  if seq.join == "0"*seq.size
    return 0
  else
    new_seq = seq.each_cons(2).map do |(x,y)|
      y-x
    end
    return seq.last + find_next(new_seq)
  end
end

def find_prev seq
  if seq.join == "0"*seq.size
    return 0
  else
    new_seq = seq.each_cons(2).map do |(x,y)|
      y-x
    end
    return seq.first - find_prev(new_seq)
  end
end

def run seqs, f
  vals = seqs.map do |seq|
    method(f).call seq
  end
  vals.sum
end

p "Part 1: #{run seqs, :find_next}"
p "Part 2: #{run seqs, :find_prev}"
