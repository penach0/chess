require_relative 'chess'
# This class will generate all available moves given a starting coordinate
class MoveGenerator
  def initialize(board, coordinate)
    @board = board
    @coordinate = coordinate
  end

  def possible_destinations
    paths.map(&:piece_scope).flatten
  end

  def paths
    piece.available_paths(board)
  end

  def piece
    board.piece_in(coordinate)
  end
end
