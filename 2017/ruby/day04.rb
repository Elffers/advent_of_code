phrases = File.readlines('day4.in').map(&:split)

sorted = phrases.map do |phrase|
  phrase.map { |word| word.chars.sort }
end

counts = [phrases, sorted].map do |list|
  list.count {|p| p == p.uniq }
end

p counts
