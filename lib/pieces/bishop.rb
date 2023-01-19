require_relative '../chess'
# This class represents a bishop chess piece
class Bishop < Piece
  MOVES = DIAGONAL.values

  def initialize(position, color, fen_value)
    super
    @symbol = (color == 'white' ? ' ♗ ' : ' ♝ ')
  end

  def available_paths(board)
    board.find_paths(position, MOVES)
  end
end
