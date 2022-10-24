require_relative 'coordinates'

# Represents a Chessboard
class Board
  include Coordinates
  attr_reader :board

  def initialize(board = nil)
    @board = board || Array.new(8) { Array.new(8, '   ') }
  end

  def board_background
    board.map.with_index do |line, row_index|
      color_line(line, row_index)
    end
  end

  def color_line(line, row_index)
    line.map.with_index do |square, col_index|
      coordinate_sum = row_index + col_index
      coordinate_sum.even? ? light_square(square) : dark_square(square)
    end
  end

  def dark_square(square)
    "\e[1;48;5;94m#{square}\e[0m"
  end

  def light_square(square)
    "\e[1;48;5;179m#{square}\e[0m"
  end

  def to_s
    board_background.each do |line|
      puts line.join
    end
  end
end
