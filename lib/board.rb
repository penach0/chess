require_relative 'coordinates'

# Represents a Chessboard
class Board
  include Coordinates
  attr_reader :board

  DARK_SQUARE = "\e[48;5;94m   \e[0m".freeze
  LIGHT_SQUARE = "\e[48;5;179m   \e[0m".freeze

  def initialize(board = nil)
    @board = board || create_board
  end

  def create_board
    Array.new(8) { Array.new(8) }.map.with_index do |line, row_index|
      create_line(line, row_index)
    end
  end

  def create_line(line, row_index)
    line.map.with_index do |_square, col_index|
      coordinate_sum = row_index + col_index
      coordinate_sum.even? ? LIGHT_SQUARE : DARK_SQUARE
    end
  end

  def to_s
    board.each do |line|
      puts line.join
    end
  end
end
