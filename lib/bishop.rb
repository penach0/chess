require_relative 'chess'
# This class represents a bishop chess piece
class Bishop < Piece
  include Directions
  include MoveChecker

  def initialize(position, color, fen_value)
    super
    @symbol = (color == 'white' ? ' ♗ ' : ' ♝ ')
  end

  def available_paths(board)
    find_paths(position, diagonals(board.board))
  end
end
