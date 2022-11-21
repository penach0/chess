require_relative 'chess'
# This class represents a Pawn chess piece
class Pawn < Piece
  attr_reader :first_move

  def initialize(position, color, fen_value)
    super
    @symbol = (color == 'white' ? ' ♙ ' : ' ♟︎ ')
    @first_move = true
  end

  def possible_moves(board)
    allowed_forward(board) + possible_captures(board)
  end

  def path(board)
    row, column = algebraic_to_array(position)
    board = board.board

    first_square = board[row - 1][column]
    second_square = board[row - 2][column]

    [first_square, second_square]
  end

  def allowed_forward(board)
    full_path = path(board)
    first_square, second_square = full_path

    return [] if first_square.occupied?
    return first_square if second_square.occupied?
    return full_path if first_move

    first_square
  end

  def possible_captures(board)
    attacked_squares(board).reject { |square| square.piece.same_color?(self) || square.empty? }
  end

  def attacked_squares(board)
    row, column = algebraic_to_array(position)

    left_square = board.board[row - 1][column - 1]
    right_square = board.board[row - 1][column + 1]

    [left_square, right_square].compact
  end
end
