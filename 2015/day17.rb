require 'pry'

def combinations sum, sizes
  p sum: sum, sizes: sizes
  count = 0
  sizes = sizes.dup

  if sum <= 0
    p count: 0
    return 0
  end

  if sizes.empty?
    p count: 0
    return 0
  end

  if sizes.include? sum
    dups = sizes.count(sum)
    count += dups
    sizes.delete(sum)
    if sizes.empty?
      p count: count
      return count
    end
  end

  if sizes.reduce(:+) == sum
    count += 1
    p count: count
    return count
  end

  max_duplicates = sizes.count(sizes.first)
  max = sizes.shift

  count += max_duplicates * combinations(sum - max, sizes)

  sizes.delete(max)
  count += combinations(sum, sizes)

  p count: count
  count
end

sizes = [
  50,
  44,
  11,
  49,
  42,
  46,
  18,
  32,
  26,
  40,
  21,
  7 ,
  18,
  43,
  10,
  47,
  36,
  24,
  22,
  40,
].sort.reverse
p combinations 150, sizes
