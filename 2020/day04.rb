input = File.read("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day04.in").split("\n\n")

def valid_byr(val) # four digits; at least 1920 and at most 2002.
  (1920..2002).include? val.to_i
end

def valid_iyr(val) # four digits; at least 2010 and at most 2020.
  (2010..2020).include? val.to_i
end

def valid_eyr(val) # four digits; at least 2020 and at most 2030.
  (2020..2030).include? val.to_i
end

# a number followed by either cm or in:
# If cm, the number must be at least 150 and at most 193.
# If in, the number must be at least 59 and at most 76.
def valid_hgt(val)
  if (/(?<num>\d+(?<unit>in|cm))/ =~ val)
    num = num.to_i
    case unit
    when"cm"
      return (num >= 150) && (num <= 193)
    when "in"
      return (num >= 59) && (num <= 76)
    end
  end
end

def valid_hcl(val) # a # followed by exactly six characters 0-9 or a-f.
  /^#[0-9a-f]{6}$/ =~ val
end

def valid_ecl(val) # exactly one of: amb blu brn gry grn hzl oth.
  /^(amb|blu|brn|gry|grn|hzl|oth)$/ =~ val
end

def valid_pid(val) # a nine-digit number, including leading zeroes.
  /^[0-9]{9}$/ =~ val
end

def is_extra_valid(data)
  data.each do |k, val|
    if k == "cid"
      next
    end
    ok = send("valid_#{k}", val)
    if !ok
      return false
    end
  end
  true
end

valid = 0
extra_valid = 0

input.each do |passport|
  passport.gsub! "\n", " "
  data = {}
  passport.split(" ").each do |field|
    k, v = field.split(":")
    data[k] = v
  end

  if data.keys.size == 8
    valid += 1
    extra_valid += 1 if is_extra_valid(data)
  end

  if (data.keys.size == 7) && !data.keys.include?("cid")
    valid += 1
    extra_valid += 1 if is_extra_valid(data)
  end
end

p "part 1: #{valid}"
p "part 2: #{extra_valid}"
