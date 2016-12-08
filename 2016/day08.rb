class Auth
  attr_accessor :board

  def initialize row, col
    @board = row.times.map { ['.'] * col }
  end

  def extract_digits instr
    /(\d+)\D+(\d+)/ =~ instr
    [$1, $2].map(&:to_i)
  end

  def follow instr
    x, y = extract_digits instr

    if instr['rect']
      (0...y).to_a.each do |row|
        (0...x).to_a.each do |col|
          board[row][col] = "#"
        end
      end
    end

    if instr['rotate row']
      board[x] = shift board[x], y
    end

    if instr['rotate column']
      t = board.transpose
      shift t[x], y
      t[x] = shift t[x], y
      self.board = t.transpose
    end
  end

  def shift row, n
    length = row.length
    new_row = ['.'] * length

    row.each_with_index do |x, i|
      shifted = (i + n) % length
      new_row[shifted] = x
    end

    new_row
  end

  def count_lit
    board.flatten.count { |x| x == '#' }
  end
end

if __FILE__ == $0
  input = File.readlines('day8.in').map{ |x| x.strip }
  a = Auth.new 6, 50

  input.each do |instr|
    a.follow instr
  end

  p a.count_lit

  # part 2
  a.board.map(&:join).map do |line|
    line.gsub!(".", " ")
    puts line
  end
end
