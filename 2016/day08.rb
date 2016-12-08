class Auth
  attr_accessor :board

  def initialize row, col
    @board = init_board row, col
  end

  def init_board row, col
    row.times.map { ['.'] * col }
  end

  def extract pixels
    /(\d+)\D+(\d+)/ =~ pixels
    [$1, $2].map(&:to_i)
  end

  def follow line
    x, y = extract line

    if line['rect']
      (0...y).to_a.each do |row|
        (0...x).to_a.each do |col|
          board[row][col] = "#"
        end
      end
    end

    if line['rotate row']
      board[x] = shift board[x], y
    end

    if line['rotate column']
      t = board.transpose
      shift t[x], y
      t[x] = shift t[x], y
      self.board = t.transpose
    end
  end

  def shift row, n
    new_row = Array.new row.length, '.'
    length = row.length

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
end
