jumps = File.readlines('day5.in').map { |x| x.to_i }
finish = jumps.size
i = 0
steps = 0

while i < finish
  j = i
  jump = jumps[i]
  i += jump

  if jump > 2
    jumps[j] = jump - 1
  else
    jumps[j] = jump + 1
  end

  steps += 1
end

p steps

