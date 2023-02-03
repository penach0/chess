require_relative 'chess'
# This class represents a collection of all of a piece's legal moves.
# It will do work on finding moves and validating them
class MoveSet
  attr_reader :board, :starting_position, :piece

  def initialize(board, piece)
    @board = board
    @piece = piece
  end

  def legal_moves
    attacking.reject { |square| forbidden_move?(square) }
  end

  def forbidden_move?(square)
    square.occupied?(piece.color) || moves_into_check?(square)
  end

  def moves_into_check?(square)
    board_dup = board.clone

    board_dup.move_piece(piece.position, square.coordinate)

    board_dup.in_check?(piece.color)
  end

  def attacking
    available_paths.map(&:piece_scope)
                   .flatten
  end

  def available_paths
    piece.directions
         .map { |direction| Path.new(board, piece.position, direction) }
  end
end
