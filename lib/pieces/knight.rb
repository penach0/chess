require_relative '../chess'
# This class describes a Knight piece
class Knight < Piece
  KNIGHT_MOVES = [[-2, -1], [-2, 1], [-1, -2], [-1, 2],
                  [1, -2], [1, 2], [2, -1], [2, 1]].freeze

  def post_initialize
    @movement = { attacking: KNIGHT_MOVES }
    @steps = 1
  end

  def minor_piece?
    true
  end
end
