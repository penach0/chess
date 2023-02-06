require_relative '../chess'
# This class describes a Knight piece
class Knight < Piece
  MOVES = [[-2, -1], [-2, 1], [-1, -2], [-1, 2],
           [1, -2], [1, 2], [2, -1], [2, 1]].freeze

  def attacking_paths(board)
    directions.map { |direction| Path.new(board, position, direction, steps: 1) }
  end

  def minor_piece?
    true
  end

  def directions
    MOVES
  end
end
