require_relative '../chess'
# This class represents a Queen piece
class Queen < Piece
  MOVES = ALL_DIRECTIONS.values

  def possible_moves(board)
    MoveSet.legal_moves(board, self)
  end

  def attacking(board)
    MoveSet.attacking(board, self)
  end

  def attacking_paths(board)
    directions.map { |direction| Path.new(board, position, direction) }
  end

  def directions
    MOVES
  end
end
