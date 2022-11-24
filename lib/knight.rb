require_relative 'chess'
# This class describes a Knight piece
class Knight < Piece
  def initialize(position, color, fen_value)
    super
    @symbol = (color == 'white' ? ' ♘ ' : ' ♞ ')
  end

  def possible_moves(board)
    all_moves = attacking(board)

    all_moves.reject { |square| square.piece.same_color?(self) }
  end

  def attacking(board)
    board.l_shape(position)
  end
end
