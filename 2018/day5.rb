polymer = File.read("./inputs/day5.in").strip.chars
polymer = "dabAcCaCBAcCcaDA".chars

# 32 difference in ord between upper and lower

def react polymer
  done = false
  last = 0
  while !done
    polymer.each_cons(2).with_index do |pair, i|
      if i < last
        next
      end

      a, b = pair
      if (a.ord - b.ord).abs == 32
        polymer.delete_at(i)
        polymer.delete_at(i)
        last = i - 1
        break
      elsif i == polymer.size - 2
        done = true
      end
    end
  end

  # p reduced
  # reduced.size
  p polymer.join
  polymer.size
end

def react2(polymer)
  i = 0
  loop do
    break unless a = polymer[i]
    break unless b = polymer[i + 1]

    if (("a".."z").include?(a) and a.upcase == b) or
        (("A".."Z").include?(a) and a.downcase == b) then
      polymer.delete_at i
      polymer.delete_at i

      i -= 1

      next
    end

    i += 1
  end

  p polymer.join
  polymer.size
end

p "Part 1: #{react polymer}"
p "Part 1 (drbrain): #{react2 polymer}" # runs correctly only if react called first
#
# sizes = {}

# ("k".."z").each do |x|
#   reduced = polymer.dup
#   reduced.delete(x)
#   reduced.delete(x.upcase)
#   sizes[x] = react reduced
#   p sizes
# end
# p sizes.min_by { |x, y| y }
# # 4688 too high
