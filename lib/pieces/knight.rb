require_relative '../chess'
# This class describes a Knight piece
class Knight < Piece
  MOVES = [[-2, -1], [-2, 1], [-1, -2], [-1, 2],
           [1, -2], [1, 2], [2, -1], [2, 1]].freeze

  def possible_moves(board)
    MoveSet.legal_moves(board, self, steps: 1)
  end

  def attacking(board)
    MoveSet.attacking(board, self, steps: 1)
  end

  def minor_piece?
    true
  end

  def directions
    MOVES
  end
end
