buckets = File.read('day6.in').chomp.split("\t").map { |x| x.to_i }
# buckets = [0, 2, 7, 0]

def distribute buckets
  max = buckets.max
  i = buckets.index(max) # always finds first, so accounts for lower bucket winning a tie
  buckets[i] = 0
  i = (i + 1) % buckets.size

  while max > 0
    buckets[i] += 1
    i = (i + 1) % buckets.size
    max -= 1
  end
  buckets
end

seen = Hash.new 0
steps = 0

while seen[buckets] == 0
  seen[buckets] = steps
  buckets = distribute buckets
  steps += 1
end

p steps
p steps - seen[buckets]
