require_relative 'chess'
# This class represents a collection of all of a piece's legal moves.
# It will do work on finding moves and validating them
class MoveSet
  attr_reader :board, :paths, :piece

  def self.legal_moves(board, piece)
    new(board, piece).legal_moves
  end

  def self.attacking(board, piece)
    new(board, piece).attacking
  end

  def initialize(board, piece)
    @board = board
    @piece = piece
  end

  def legal_moves
    attacking.reject { |square| forbidden_move?(square) }
  end

  def attacking
    piece.available_paths(board)
         .map(&:piece_scope)
         .flatten
  end

  private

  def forbidden_move?(square)
    square.occupied?(piece.color) || moves_into_check?(square)
  end

  def moves_into_check?(square)
    board_dup = board.clone

    board_dup.move_piece(piece.position, square.coordinate)

    board_dup.in_check?(piece.color)
  end
end
