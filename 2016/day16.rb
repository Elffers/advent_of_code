def dragonize data
  a = data
  b = a.dup.reverse
  b.tr!("10", "01")
  a + "0" + b
end

def generate_checksum data
  checksum = data.chars.each_slice(2).map do |a, b|
    (a.to_i ^ b.to_i).to_s
  end
  checksum.join.tr!("10", "01")
end

def find_checksum data, size
  while data.length < size
    data = dragonize data
  end

  chars = data[0...size]

  checksum = generate_checksum chars

  while checksum.length.even?
    checksum = generate_checksum checksum
  end

  checksum
end

# p find_checksum "10000", 20
# p find_checksum "11100010111110100", 272
p find_checksum "11100010111110100", 35651584

