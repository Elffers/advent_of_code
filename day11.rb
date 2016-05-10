# --- Day 11: Corporate Policy ---

# Santa's previous password expired, and he needs help choosing a new one.

# To help him remember his new password after the old one expires, Santa has
# devised a method of coming up with a password based on the previous one.
# Corporate policy dictates that passwords must be exactly eight lowercase
# letters (for security reasons), so he finds his new password by incrementing
# his old password string repeatedly until it is valid.

# Incrementing is just like counting with numbers: xx, xy, xz, ya, yb, and so
# on. Increase the rightmost letter one step; if it was z, it wraps around to
# a, and repeat with the next letter to the left until one doesn't wrap
# around.

# Unfortunately for Santa, a new Security-Elf recently started, and he has
# imposed some additional password requirements:

# - Passwords must include one increasing straight of at least three letters,
#   like abc, bcd, cde, and so on, up to xyz. They cannot skip letters; abd
#   doesn't count.
#
# - Passwords may not contain the letters i, o, or l, as these
#   letters can be mistaken for other characters and are therefore confusing.
#
# - Passwords must contain at least two different, non-overlapping pairs of
#   letters, like aa, bb, or zz.
#
# For example:

# hijklmmn meets the first requirement (because it contains the straight hij)
# but fails the second requirement requirement (because it contains i and l).
#
# abbceffg meets the third requirement (because it repeats bb and ff) but
# fails the first requirement.
#
# abbcegjk fails the third requirement, because
# it only has one double letter (bb).
#
# The next password after abcdefgh is abcdffaa.  The next password after
# ghijklmn is ghjaabcc, because you eventually skip all the passwords that
# start with ghi..., since i is not allowed.
#
# Given Santa's current password (your puzzle input), what should
# his next password be?

# Your puzzle input is hepxcrrq.

def next_password password
  password = password.next
  until valid? password
    password = password.next
  end
  password
end

def prohibited? password
  /i|o|l/ =~ password
end

def has_double_repeated? password
  /(.)\1.*(.)\2/ =~ password
end

def has_straight? password
  password.chars.each_cons(3) do |a, b, c|
    return true if a.next == b && b.next == c
  end
  false
end

def valid? password
  return false if prohibited? password
  (has_double_repeated? password) && (has_straight? password)
end

# p next_password(next_password "hepxcrrq")
p next_password "ghijklmn"
