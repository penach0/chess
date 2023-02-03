require_relative 'chess'
# This class represents a collection of all of a piece's legal moves.
# It will do work on finding moves and validating them
class MoveSet
  attr_reader :board, :starting_position, :piece

  def initialize(board, coordinate, piece)
    @starting_position = coordinate
    @piece = piece
    @board = board
  end

  def legal_moves
    attacking.reject { |square| forbidden_move?(square, starting_position) }
  end

  def forbidden_move?(square, starting_position)
    square.occupied?(piece.color) || moves_into_check?(square, starting_position)
  end

  def moves_into_check?(square, starting_position)
    board_dup = board.clone

    board_dup.move_piece(starting_position, square.coordinate)

    board_dup.in_check?(piece.color)
  end

  def attacking
    available_paths.map(&:piece_scope)
                   .flatten
  end

  def available_paths
    piece.directions
         .map { |direction| Path.new(board, starting_position, direction) }
  end
end
