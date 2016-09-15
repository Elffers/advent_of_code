# --- Day 20: Infinite Elves and Infinite Houses ---

# To keep the Elves busy, Santa has them deliver some presents by hand,
# door-to-door. He sends them down a street with infinite houses numbered
# sequentially: 1, 2, 3, 4, 5, and so on.

# Each Elf is assigned a number, too, and delivers presents to houses based on
# that number:

# The first Elf (number 1) delivers presents to every house: 1, 2, 3, 4, 5,
# ....  The second Elf (number 2) delivers presents to every second house: 2,
# 4, 6, 8, 10, ....  Elf number 3 delivers presents to every third house: 3,
# 6, 9, 12, 15, ....  There are infinitely many Elves, numbered starting with
# 1. Each Elf delivers presents equal to ten times his or her number at each
# house.

# So, the first nine houses on the street end up like this:

# House 1 got 10 presents.  House 2 got 30 presents.  House 3 got 40 presents.
# House 4 got 70 presents.  House 5 got 60 presents.  House 6 got 120
# presents.  House 7 got 80 presents.  House 8 got 150 presents.  House 9 got
# 130 presents.  The first house gets 10 presents: it is visited only by Elf
# 1, which delivers 1 * 10 = 10 presents. The fourth house gets 70 presents,
# because it is visited by Elves 1, 2, and 4, for a total of 10 + 20 + 40 = 70
# presents.

# What is the lowest house number of the house to get at least as many
# presents as the number in your puzzle input?

# Your puzzle input is 29000000.

def count_presents(house_number)
  factors_limited(house_number).reduce(:+) * 11
end

def factors(num)
  1.upto(Math.sqrt(num)).select {|i| (num % i).zero?}.inject([]) do |f, i|
    f << i
    f << num / i unless i == num / i
    f
  end
end

def factors_limited(num)
  culled = []
  factors(num).sort.each do |f|
    if (f * 50) >= num
      culled << f
    end
  end
  culled
end


def find_house(guess)
  600_000.upto(guess).each do |num|
    presents = count_presents num
    p presents: presents, guess: num
    return num if presents >= 29_000_000
  end
end

p find_house 1_000_000
# 665280
# real	1m12.955s
# user	1m8.206s
# sys	0m2.636s
