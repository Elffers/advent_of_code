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

def rotate word, steps, right:
  steps = -steps if right
  word.chars.rotate!(steps).join
end

def reverse word, start, stop
  word[0,start] + word[start..stop].reverse + word[stop+1, word.size]
end

def move_position word, x, y, r=false
  x, y = y, x if r
  char = word[x]
  word.delete! char
  word.insert(y, char)
  word
end

def rotate_pos word, char, r=false
  index = word.index(char)
  if r
    # terrible hack; only works for size 8
    map = { 1 => 1,
            3 => 2,
            5 => 3,
            7 => 4,
            2 => -2,
            4 => -1,
            6 => 0,
            0 => 1 }
    rot = map[index]

    word.chars.rotate!(rot).join
  else
    rot = index + 1
    rot += 1 if index >= 4

    word.chars.rotate!(-rot).join
  end
end

def scramble word, input, r=false
  input.each do |line|
    word =
      if /swap\sposition\s(\d)\swith\sposition\s(\d)/ =~ line
        x, y = $1.to_i, $2.to_i
        swap_position word, x, y

      elsif /swap\sletter\s(\w)\swith\sletter\s(\w)/ =~ line
        x, y = $1, $2
        swap_letters word, x, y

      elsif /rotate\sleft\s(\d)/ =~ line
        steps = $1.to_i
        rotate word, steps, right: r

      elsif /rotate\sright\s(\d)/ =~ line
        steps = $1.to_i
        rotate word, steps, right: !r

      elsif /rotate\sbased\son\sposition\sof\sletter\s(\w)/ =~ line
        rotate_pos word, $1, r

      elsif /reverse\spositions\s(\d)\sthrough\s(\d)/ =~ line
        reverse(word, $1.to_i, $2.to_i)

      elsif /move\sposition\s(\d)\sto\sposition\s(\d)/ =~ line
        x, y = $1.to_i, $2.to_i
        move_position word, x, y, r

      end
    # p [word, line]
  end

  word
end

if __FILE__ == $0
  # test_input = File.readlines('day21_test.in').map { |x| x.strip }
  # word = 'abcde'
  # p scramble(word, test_input)
  # p scramble('decab', test_input.reverse, true)

  input = File.readlines('day21.in').map { |x| x.strip }
  word = 'abcdefgh'
  scrambled = 'aefgbcdh'
  p scramble(word, input) == scrambled # part 1
  p scramble(scrambled, input.reverse, true)

  scrambled = 'fbgdceah'
  p scramble(scrambled, input.reverse, true)

  # b = "abcde"
  # b.each_char.with_index do |c, i|
  #   new_word = rotate_pos(b, c)
  #   p [new_word, i, new_word.index(c)]
  # end
  # p '===='

  # b = "abcdef"
  # b.each_char.with_index do |c, i|
  #   new_word = rotate_pos(b, c)
  #   p [new_word, i, new_word.index(c)]
  # end

  # p '===='
  # b = "abcdefg"
  # b.each_char.with_index do |c, i|
  #   new_word = rotate_pos(b, c)
  #   p [new_word, i, new_word.index(c)]
  # end

  # p '===='
  # b = "abcdefgh"
  # b.each_char.with_index do |c, i|
  #   new_word = rotate_pos(b, c)
  #   p [new_word, c, i, new_word.index(c)]
  # end
end
