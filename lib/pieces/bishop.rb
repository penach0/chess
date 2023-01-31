require_relative '../chess'
# This class represents a bishop chess piece
class Bishop < Piece
  MOVES = DIAGONAL.values

  def available_paths(board)
    board.find_paths(position, MOVES)
  end
end
