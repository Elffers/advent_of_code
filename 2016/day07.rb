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

p parse 'abba[mnop]qrst'
p parse 'abcd[bddb]xyyx'
p parse 'aaaa[qwer]tyui'
p parse 'ioxxoj[asdfgh]zxcvbn'
p parse 'xdsqxnovprgovwzkus[fmadbfsbqwzzrzrgdg]aeqornszgvbizdm'

input = File.readlines('day07.in').map { |x| x.strip }
p input.count { |line| parse line }

