require_relative 'chess'
# This class describes a Knight piece
class Knight < Piece
  MOVES = [[-2, -1], [-2, 1], [-1, -2], [-1, 2],
           [1, -2], [1, 2], [2, -1], [2, 1]].freeze

  def initialize(position, color, fen_value)
    super
    @symbol = (color == 'white' ? ' ♘ ' : ' ♞ ')
  end

  def possible_moves(board)
    all_moves = attacking(board)

    all_moves.reject { |square| square.piece.same_color?(self) }
  end

  def attacking(board)
    board.single_move_finder(position, MOVES)
  end
end
