require_relative '../chess'
# This class represents a bishop chess piece
class Bishop < Piece
  MOVES = DIAGONAL.values

  def directions
    MOVES
  end

  def minor_piece?
    true
  end
end
