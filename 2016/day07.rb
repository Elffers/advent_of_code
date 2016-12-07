def parse line
  words = line.split(/\[|\]/)
  palindromes = []
  non_palindromes = []
  words.each_with_index do |w, i|
    if has_palin w
      if i.even?
        palindromes << w
      else
        non_palindromes << w
      end
    end
  end
  p "palindromes: #{palindromes}"

  line if !palindromes.empty? && non_palindromes.empty?
end

def has_palin word
  (/(\w)(\w)\2\1/ =~ word) && ($1 != $2)
end

# p parse 'abba[mnop]qrst'
# p parse 'abcd[bddb]xyyx'
# p parse 'aaaa[qwer]tyui'
# p parse 'ioxxoj[asdfgh]zxcvbn'
# p parse 'xdsqxnovprgovwzkus[fmadbfsbqwzzrzrgdg]aeqornszgvbizdm'

# input = File.readlines('day07.in').map { |x| x.strip }
# p input.count { |line| parse line }

def aba? word
  abas = []
  i = 0

  while i <= word.length - 3
    substring = word[i..word.length]
    if /(\w)(\w)\1/ =~ substring && $1 != $2
      abas << $&
    end
    i += 1
  end
  abas
end

def bab? words, aba
  a, b = aba.chars
  bab = b + a + b
  words.each do |word|
    return true if word.include? bab
  end
  nil
end

def parse2 line
  words = line.split(/\[|\]/)
  abas = []
  babs = []

  words.each_with_index do |w, i|
    if i.even?
      if x = aba?(w)
        abas.concat x
      end
    else
      babs << w
    end
  end
  # p "abas: #{abas}"

  abas.each do |aba|
    return line if bab? babs, aba
  end
  nil
end


p parse2 'aba[bab]xyz' #yes
p parse2 'xyx[xyx]xyx' #no
p parse2 'aaa[kek]eke' #yes
p parse2 'zazbz[bzb]cdb' #yes

input = File.readlines('day07.in').map { |x| x.strip }
p input.count { |line| parse2 line }
