def scramble word, input
  input.each do |line|
    if /swap\sposition\s(\d)\swith\sposition\s(\d)/ =~ line
      x_index = $1.to_i
      y_index = $2.to_i
      x = word[x_index]
      y = word[y_index]
      word[x_index] = y
      word[y_index] = x

    elsif /swap\sletter\s(\w)\swith\sletter\s(\w)/ =~ line
      word.tr!($1+$2, $2+$1)

    elsif /rotate\sleft\s(\d)/ =~ line
      word = word.chars.rotate!($1.to_i).join

    elsif /rotate\sright\s(\d)/ =~ line
      word = word.chars.rotate!(-$1.to_i).join

    elsif /rotate\sbased\son\sposition\sof\sletter\s(\w)/ =~ line
      index = word.index($1)
      index.times do
        word = word.chars.rotate!(-1).join
      end

      word = word.chars.rotate!(-1).join

      if index >= 4
        word = word.chars.rotate!(-1).join
      end

    elsif /reverse\spositions\s(\d)\sthrough\s(\d)/ =~ line
      start, stop = $1.to_i, $2.to_i
      word = word[0,start] + word[start..stop].reverse + word[stop+1, word.size]

    elsif /move\sposition\s(\d)\sto\sposition\s(\d)/ =~ line
      char = word[$1.to_i]
      word.delete! char
      word.insert($2.to_i, char)
    end
    # p [word, line]
  end

  word
end

input = File.readlines('day21.in').map { |x| x.strip }
word = 'abcdefgh'

p scramble(word, input)
