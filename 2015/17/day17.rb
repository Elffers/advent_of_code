# list = [20, 15, 10, 5, 5]
# target = 25
list = [50, 44, 11, 49, 42, 46, 18, 32, 26, 40, 21, 7, 18, 43, 10, 47, 36, 24, 22, 40]
target = 150

def count list, target
  n = 2
  count = 0
  while n < list.size
    count += list.combination(n).to_a.select do |combo|
      combo.reduce(:+) == target
    end.size

    n += 1
  end

  count
end

p count list, target
