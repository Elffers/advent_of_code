# --- Day 5: Doesn't He Have Intern-Elves For This? ---

# Santa needs help figuring out which strings in his text file are naughty or
# nice.

# A nice string is one with all of the following properties:

# It contains at least three vowels (aeiou only), like aei, xazegov, or
# aeiouaeiouaeiou.  It contains at least one letter that appears twice in a
# row, like xx, abcdde (dd), or aabbccdd (aa, bb, cc, or dd).  It does not
# contain the strings ab, cd, pq, or xy, even if they are part of one of the
# other requirements.  For example:

# ugknbfddgicrmopn is nice because it has at least three vowels
# (u...i...o...), a double letter (...dd...), and none of the disallowed
# substrings.
# aaa is nice because it has at least three vowels and a double letter, even
# though the letters used by different rules overlap.
# jchzalrnumimnmhp is naughty because it has no double letter.
# haegwjzuvuyypxyu is naughty because it contains the string xy.
# dvszwmarrgswjxmb is naughty because it contains only one vowel.
#
# How many strings are nice?

class SantaString
  attr_accessor :string

  def initialize(string)
    @string= string
  end

  def nice?
    return false if has_prohibited?
    return false unless has_repeated?
    count_vowels > 2
  end

  def nice2?
  end

  def count_vowels
    string.chars.count do |c|
      /[aeiou]/ =~ c
    end
  end

  def has_repeated?
    /(.)\1/ =~ string
  end

  def has_prohibited?
    /ab|cd|pq|xy/ =~ string
  end
end

if $0 == __FILE__
  strings = File.readlines('day5_input.txt')
  p strings.count { |string|
    s = SantaString.new string
    s.nice?
  }
end
