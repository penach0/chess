require_relative 'coordinates'
require_relative 'square'

# Represents a Chessboard
class Board
  include Coordinates
  attr_reader :board

  def initialize(board = Array.new(8) { Array.new(8, '   ') })
    @board = squarify_board(board)
  end

  def squarify_board(board)
    board.map.with_index do |line, row_index|
      squarify_line(line, row_index)
    end
  end

  def squarify_line(line, row_index)
    line.map.with_index do |element, col_index|
      Square.squarify(element, row_index, col_index)
    end
  end

  def square(coordinate)
    board.flatten.find { |element| element.coordinate == coordinate }
  end

  def set_piece(piece, coordinate)
    square(coordinate).update(piece)
  end

  def remove_piece(coordinate)
    square(coordinate).clear
  end

  def move_piece(piece, start_coordinate, end_coordinate)
    remove_piece(start_coordinate)
    set_piece(piece, end_coordinate)
  end

  def print_board
    board.each do |line|
      puts line.join
    end
    puts
  end
end
