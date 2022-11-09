require_relative 'coordinates'
require_relative 'square'

# Represents a Chessboard
class Board
  include Coordinates
  attr_reader :board

  SIZE = 8

  def initialize(board: Array.new(SIZE) { Array.new(SIZE, '   ') })
    @board = squarify_board(board)
  end

  def squarify_board(board)
    board.map.with_index do |line, row_index|
      squarify_line(line, row_index)
    end
  end

  def squarify_line(line, row_index)
    line.map.with_index do |element, col_index|
      coordinate = array_to_algebraic(row_index, col_index)
      color = Square.color(row_index, col_index)
      Square.new(element, coordinate, color)
    end
  end

  def square(coordinate)
    board.flatten.find { |element| element.coordinate == coordinate }
  end

  def store_piece(coordinate)
    square(coordinate).content
  end

  def place_piece(coordinate, piece)
    square(coordinate).update(piece)
  end

  def remove_piece(coordinate)
    square(coordinate).clear
  end

  def move_piece(start_coordinate, end_coordinate)
    stored_piece = store_piece(start_coordinate)

    remove_piece(start_coordinate)
    place_piece(end_coordinate, stored_piece)
  end

  def print_board
    board.each do |line|
      puts line.join
    end
    puts
  end
end
