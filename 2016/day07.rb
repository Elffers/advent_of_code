def abba? seq
  (/(\w)(\w)\2\1/ =~ seq) && ($1 != $2)
end

def supports_tls? ip
  seqs = ip.split(/\[|\]/)

  evens = seqs.select.with_index { |seq, i| i.even? && (abba? seq) }
  odds = seqs.select.with_index { |seq, i| i.odd? && (abba? seq) }

  !evens.empty? && odds.empty?
end

# part 2

def aba? seq
  abas = []
  i = 0

  while i < seq.length - 2
    substring = seq[i..seq.length]
    if /(\w)(\w)\1/ =~ substring && $1 != $2
      abas << $&
    end
    i += 1
  end

  abas
end

def bab? seqs, aba
  a, b = aba.chars
  bab = b + a + b
  seqs.any? { |seq| seq.include? bab }
end

def supports_ssl? ip
  seqs = ip.split(/\[|\]/)

  evens = seqs.select.with_index { |seq, i| i.even? }
  babs = seqs.select.with_index { |seq, i| i.odd? }

  abas = evens.map { |seq| aba? seq }.flatten

  abas.any? { |aba| bab? babs, aba }
end


# p supports_ssl? 'aba[bab]xyz'   #true
# p supports_ssl? 'xyx[xyx]xyx'   #false
# p supports_ssl? 'aaa[kek]eke'   #true
# p supports_ssl? 'zazbz[bzb]cdb' #true

input = File.readlines('day07.in').map { |x| x.strip }
p input.count { |ip| supports_tls? ip }
p input.count { |ip| supports_ssl? ip }
