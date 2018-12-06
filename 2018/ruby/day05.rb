polymer = File.read("./inputs/day5.in").strip.chars
# polymer = "dabAcCaCBAcCcaDA".chars

# codepoint difference between upper and lowercase letters is 32
CODEPOINT_DIFF = 32

def react polymer
  polymer = polymer.dup
  reduced = [] # Use stack

  a = polymer.shift
  reduced << a

  while !polymer.empty?
    # compare top of stack with next element in polymer
    a = reduced.last
    b = polymer.shift

    if a.nil?
      reduced << b
    elsif (a.ord - b.ord).abs == CODEPOINT_DIFF
      reduced.pop
    else
      reduced << b
    end

  end

  reduced.size
end

p "Part 1: #{react polymer}"

# Part 2
sizes = {}

("a".."z").each do |x|
  reduced = polymer.dup
  reduced.delete(x)
  reduced.delete(x.upcase)
  sizes[x] = react reduced
end

letter, size = sizes.min_by{ |letter, size| size }

p "Part 2: #{size}"
