require_relative '../chess'
# This class describes a Knight piece
class Knight < Piece
  MOVES = [[-2, -1], [-2, 1], [-1, -2], [-1, 2],
           [1, -2], [1, 2], [2, -1], [2, 1]].freeze

  def initialize(position, color, fen_value)
    super
    @symbol = (color == 'white' ? ' ♘ ' : ' ♞ ')
  end

  def attacking(board)
    board.find_single_moves(position, MOVES)
  end
end
