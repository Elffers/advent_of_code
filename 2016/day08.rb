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
      board[x].rotate!(-y)
    end

    if instr['rotate column']
      t = board.transpose
      t[x].rotate!(-y)
      self.board = t.transpose
    end
  end

  def count_lit
    board.flatten.count('#')
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
