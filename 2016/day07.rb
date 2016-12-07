def parse ip
  seqs = ip.split(/\[|\]/)
  evens, odds = seqs.partition.with_index { |seq, i| i.even? }

  yield evens, odds
end

def abba? seq
  (/(\w)(\w)\2\1/ =~ seq) && ($1 != $2)
end

def supports_tls? ip
  parse ip do |evens, odds|
    evens.any? { |seq| abba? seq } &&
    odds.none? { |seq| abba? seq }
  end
end

# part 2

def aba? seq
  abas = []
  seq.chars.each_cons(3) do |substring|
    if /(\w)(\w)\1/ =~ substring.join && $1 != $2
      abas << $&
    end
  end

  abas
end

def bab? seqs, aba
  a, b = aba.chars
  bab = b + a + b
  seqs.any? { |seq| seq.include? bab }
end

def supports_ssl? ip
  parse ip do |evens, odds|
    abas = evens.map { |seq| aba? seq }.flatten
    abas.any? { |aba| bab? odds, aba }
  end
end

# p supports_ssl? 'aba[bab]xyz'   #true
# p supports_ssl? 'xyx[xyx]xyx'   #false
# p supports_ssl? 'aaa[kek]eke'   #true
# p supports_ssl? 'zazbz[bzb]cdb' #true

input = File.readlines('day07.in').map { |x| x.strip }
p input.count { |ip| supports_tls? ip }
p input.count { |ip| supports_ssl? ip }
