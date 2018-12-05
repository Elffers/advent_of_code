polymer = File.read("./inputs/day5.in").chomp.chars
# p polymer
# polymer = "dabAcCaCBAcCcaDA".chars

# 32 difference in ord between upper and lower

def react polymer
  done = false
  while !done
    polymer.each_cons(2).with_index do |pair, i|
      a, b = pair
      if (a.ord - b.ord).abs == 32
        polymer.delete_at(i)
        polymer.delete_at(i)
        break
      elsif i == polymer.size - 2
        done = true
      end
    end
  end

  polymer.size
end

p "Part 1: #{react polymer}"

