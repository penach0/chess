require_relative 'chess'
# This class represents a collection of all of a piece's legal moves.
# It will do work on finding moves and validating them
class MoveSet
  attr_reader :board, :piece

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
    paths = piece.available_paths(board)

    squares_for(paths).reject { |square| forbidden_move?(square) }
  end

  def attacking
    paths = piece.attacking_paths(board)

    squares_for(paths)
  end

  private

  def squares_for(paths)
    paths.map(&:piece_scope).flatten
  end

  def forbidden_move?(square)
    square.occupied?(piece.color) || moves_into_check?(square)
  end

  def moves_into_check?(square)
    board_dup = board.clone

    board_dup.move_piece(Move.new(piece.position, square.coordinate))

    board_dup.in_check?(piece.color)
  end
end
