require_relative '../chess'
# This class represents a bishop chess piece
class Bishop < Piece
  MOVES = DIAGONAL.values

  def possible_moves(board)
    MoveSet.legal_moves(board, self)
  end

  def attacking(board)
    MoveSet.attacking(board, self)
  end

  def directions
    MOVES
  end

  def minor_piece?
    true
  end
end
