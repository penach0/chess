require_relative 'chess'
# This class will generate all available moves given a starting coordinate
class MoveGenerator
  def initialize(board, coordinate)
    @board = board
    @coordinate = coordinate
  end

  def piece
    board.piece_in(coordinate)
  end

  def paths
    piece.available_paths(board)
  end
end
