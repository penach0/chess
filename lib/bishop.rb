require_relative 'chess'
# This class represents a bishop chess piece
class Bishop < Piece
  def initialize(position, color, fen_value)
    super
    @symbol = (color == 'white' ? ' ♗ ' : ' ♝ ')
  end

  def available_paths(board)
    board.find_paths(position, :diagonals)
  end
end
