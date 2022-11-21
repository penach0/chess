require_relative 'chess'
# This class represents a Pawn chess piece
class Pawn < Piece
  def initialize(position, color, fen_value)
    super
    @symbol = (color == 'white' ? ' ♙ ' : ' ♟︎ ')
    @first_move = false
  end

  def attacked_squares(board)
    row, column = algebraic_to_array(position)

    left_square = board.board[row - 1][column - 1]
    right_square = board.board[row - 1][column + 1]

    [left_square, right_square].compact
  end
end
