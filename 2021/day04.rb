input = File.read("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day04.in").split "\n\n"
nums = input.shift
nums = nums.split ","
p nums

class Board
  attr_reader :board
  attr_accessor :marks, :last_num

  def initialize str
    @board = str.split("\n").map { |row| row.split " " }
    @marks = Array.new(5) { Array.new(5) }
  end

  def mark num
    board.each_with_index do |row, i|
      row.each_with_index do |y, j|
        if y == num
          self.marks[i][j] = true
          @last_num = num
        end
      end
    end
  end

  def winning?
    has_row = marks.any? { |row| row.all? { |m| m == true } }
    has_col = marks.transpose.any? { |row| row.all? { |m| m == true } }
    has_row || has_col
  end

  def score
    sum = 0
    marks.each_with_index do |row, i|
      row.each_with_index do |y, j|
        if y.nil?
          sum += board[i][j].to_i
        end
      end
    end
    sum * last_num.to_i
  end
end

boards = input.map do |s|
  Board.new s
end

nums.each do |n|
  boards.each do |b|
    b.mark n
    if b.winning?
      p "Part 1: #{b.score}"
      return
    end
  end
end
