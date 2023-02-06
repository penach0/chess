require_relative '../chess'
# This class represents a Queen piece
class Queen < Piece
  MOVES = ALL_DIRECTIONS.values

  def available_paths(board)
    attacking_paths(board)
  end

  def attacking_paths(board)
    directions.map { |direction| Path.new(board, position, direction) }
  end

  def directions
    MOVES
  end
end
