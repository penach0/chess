require_relative 'chess'
# This class describes a Knight piece
class Knight < Piece
  def initialize(position, color, fen_value)
    super
    @symbol = (color == 'white' ? ' ♘ ' : ' ♞ ')
  end

  def possible_moves(board)
    all_moves = attacked_squares(board)
    possible_moves = all_moves.reject { |square| square.piece.same_color?(self) }

    square_to_coordinates(possible_moves)
  end

  def attacked_squares(board)
    l_shape(position, board.board)
  end
end
