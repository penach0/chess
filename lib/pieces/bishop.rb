require_relative '../chess'
# This class represents a bishop chess piece
class Bishop < Piece
  MOVES = DIAGONAL.values

  def available_paths(board)
    attacking_paths(board)
  end

  def attacking_paths(board)
    directions.map { |direction| Path.new(board, position, direction) }
  end

  def directions
    MOVES
  end

  def minor_piece?
    true
  end
end
