require 'set'

input = File.readlines("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day21.in").map { |x| x.strip }

allergens = Hash.new
ing_count = Hash.new 0

input.each do |x|
  x, algns = x.split("(contains ")
  ingredients = Set.new(x.split(" "))

  ingredients.each do |i|
    ing_count[i] += 1
  end

  algns.chop.split(", ").each do |a|
    if allergens[a].nil?
      allergens[a] = ingredients
    else
      existing = allergens[a]
      allergens[a] = existing & ingredients
    end
  end
end

# copied from day 16
allergen_map = Hash.new
seen = Set.new
s = Set.new(allergens.keys)

while !s.empty?
  allergens.each do |k, v|
    copy = v.dup
    copy.each do |n|
      if seen.include? n
        v.delete n
      end
    end
    if v.length == 1
      seen << v.first
      allergen_map[k] = v.first
      s.delete k
    end
  end
end

res = 0
ing_count.each do |i, count|

  if !allergen_map.values.include?(i)
    res += count
  end
end

p "part 1: #{res}"

# part 2
puts allergen_map.sort_by { |k, v| k }.map { |pair| pair.last}.join(",")
