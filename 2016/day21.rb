def swap_position word, x, y
  x_index = x.to_i
  y_index = y.to_i
  x = word[x_index]
  y = word[y_index]
  word[x_index] = y
  word[y_index] = x
  word
end

def swap_letters word, a, b
  word.tr!(a+b, b+a)
end

def rotate_left word, steps
  word.chars.rotate!(steps).join
end

def rotate_right word, steps
  word.chars.rotate!(-steps).join
end

def reverse word, start, stop
  word[0,start] + word[start..stop].reverse + word[stop+1, word.size]
end

def move_position word, x, y
  char = word[x]
  word.delete! char
  word.insert(y, char)
  word
end

def rotate_pos word, char, u=true
  index = word.index(char)
  rot = index + 1
  rot += 1 if index >= 4

  rot = -rot if u

  word.chars.rotate!(rot).join

end

def scramble word, input, u=true
  input.each do |line|
    if /swap\sposition\s(\d)\swith\sposition\s(\d)/ =~ line
      if u
        word = swap_position word, $1.to_i, $2.to_i
      else
        word = swap_position word, $2.to_i, $1.to_i
      end

    elsif /swap\sletter\s(\w)\swith\sletter\s(\w)/ =~ line
      if u
        word = swap_letters(word, $1, $2)
      else
        word = swap_letters(word, $2, $1)
      end

    elsif /rotate\sleft\s(\d)/ =~ line
      if u
        word = rotate_left word, $1.to_i
      else
        word = rotate_right word, $1.to_i
      end

    elsif /rotate\sright\s(\d)/ =~ line
      if u
        word = rotate_right word, $1.to_i
      else
        word = rotate_left word, $1.to_i
      end

    elsif /rotate\sbased\son\sposition\sof\sletter\s(\w)/ =~ line
      index = word.index($1)
      index.times do
        word = word.chars.rotate!(-1).join
      end

      word = word.chars.rotate!(-1).join

      if index >= 4
        word = word.chars.rotate!(-1).join
      end
      # rotate_pos word, $1, u

    elsif /reverse\spositions\s(\d)\sthrough\s(\d)/ =~ line
      word = reverse(word, $1.to_i, $2.to_i)

    elsif /move\sposition\s(\d)\sto\sposition\s(\d)/ =~ line
      if u
        word = move_position word, $1.to_i, $2.to_i
      else
        word = move_position word, $2.to_i, $1.to_i
      end
    end
    p [word, line]
  end

  word
end

if __FILE__ == $0
  test_input = File.readlines('day21_test.in').map { |x| x.strip }
  word = 'abcde'
  p scramble('abcde', test_input)
  p scramble('decab', test_input.reverse, false)

  input = File.readlines('day21.in').map { |x| x.strip }
  word = 'abcdefgh'
  scrambled = 'aefgbcdh'
  p scramble(word, input) == scrambled
  # p scramble(scrambled, input.reverse, false)

  # scrambled = 'fbgdceah'
  # p scramble(scrambled, input.reverse, false)

  #hcfadgeb is wrong part 2
end
