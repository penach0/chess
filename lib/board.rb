require_relative 'coordinates'
require_relative 'fen_translator'
require_relative 'square'

# Represents a Chessboard
class Board
  include Coordinates
  include FENTranslator
  attr_reader :board

  SIZE = 8

  def initialize(board: Array.new(SIZE) { Array.new(SIZE, '   ') })
    @board = squarify_board(fen_to_array(board))
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

  def piece_in(coordinate)
    square(coordinate).piece
  end

  def pieces_of_color(color)
    board.flatten
         .filter_map { |square| square.piece if square.occupied?(color) }
  end

  def position_of_pieces(color)
    square_to_coordinates(pieces_of_color(color))
  end

  def place_piece(piece, end_coordinate = piece.position)
    square(end_coordinate).update(piece)
  end

  def remove_piece(coordinate)
    square(coordinate).clear
  end

  def move_piece(start_coordinate, end_coordinate)
    stored_piece = piece_in(start_coordinate)

    remove_piece(start_coordinate)
    place_piece(stored_piece, end_coordinate)
  end

  def print_board
    board.each do |line|
      puts line.join
    end
    puts
  end
end
