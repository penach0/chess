require_relative 'chess'
# This class represents a collection of all of a piece's legal moves.
# It will do work on finding moves and validating them
class MoveSet
  attr_reader :board, :starting_position, :piece

  def initialize(board, coordinate)
    @board = board
    @starting_position = coordinate
    @piece = board.piece_in(coordinate)
  end

  def possible_moves
    piece.attacking(board).reject { |square| forbidden_move(board, square, starting_position) }
  end

  def forbidden_move(square, piece)
    square.piece.same_color?(piece) || moves_into_check?(square, piece)
  end

  def moves_into_check?(square, piece)
    board_dup = board.clone

    board_dup.move_piece(starting_position, square.coordinate)

    board_dup.in_check?(piece.color)
  end
end
