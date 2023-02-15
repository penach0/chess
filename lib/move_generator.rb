require_relative 'chess'
# This class will generate all available moves given a starting coordinate
class MoveGenerator
  attr_reader :board, :coordinate

  def initialize(board, coordinate)
    @board = board
    @coordinate = coordinate
  end

  def legal_moves
    moves.reject { |move| illegal?(move) }
  end

  def moves
    possible_destinations.map { |destination| Move.new(coordinate, destination.coordinate) }
  end

  def illegal?(move)
    board.piece_in(move.to).same_color?(piece) || moves_into_check?(move)
  end

  def moves_into_check?(move)
    board_dup = board.clone

    board_dup.move_piece(move)

    board_dup.in_check?(piece.color)
  end

  def possible_destinations
    paths.map(&:piece_scope).flatten
  end

  def paths
    Paths.new(board, coordinate)
  end

  def piece
    board.piece_in(coordinate)
  end
end
