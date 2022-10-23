# Represents a Chessboard
class Board
  attr_reader :board

  DARK_SQUARE = "\e[48;5;94m  \e[0m".freeze
  LIGHT_SQUARE = "\e[48;5;179m  \e[0m".freeze

  def initialize(board = nil)
    @board = board || create_board
  end

  def create_board
    Array.new(8) { Array.new(8) }.map.with_index do |line, index1|
      line.map.with_index do |_square, index2|
        coordinate_sum = index1 + index2
        coordinate_sum.even? ? LIGHT_SQUARE : DARK_SQUARE
      end
    end
  end
end
