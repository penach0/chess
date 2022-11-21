require_relative 'chess'
# This class represents a Pawn chess piece
class Pawn < Piece
  attr_reader :first_move

  def initialize(position, color, fen_value)
    super
    @symbol = (color == 'white' ? ' ♙ ' : ' ♟︎ ')
    @first_move = true
  end

  def update_position(new_position)
    super

    @first_move = false if first_move
  end

  def possible_moves(board)
    square_to_coordinates(allowed_forward(board) + possible_captures(board))
  end

  def upward_path(board)
    row, column = algebraic_to_array(position)
    board = board.board

    first_square = board[row - 1][column]
    second_square = board[row - 2][column]

    [first_square, second_square]
  end

  def downward_path(board)
    row, column = algebraic_to_array(position)
    board = board.board

    first_square = board[row + 1][column]
    second_square = board[row + 2][column]

    [first_square, second_square]
  end

  def allowed_forward(board)
    full_path = (color == 'white' ? upward_path(board) : downward_path(board))
    first_square, second_square = full_path

    return [] if first_square.occupied?
    return [first_square] if second_square.occupied?
    return full_path if first_move

    [first_square]
  end

  def possible_captures(board)
    attacked_squares =
      (color == 'white' ? attacked_up(board) : attacked_down(board))

    attacked_squares.reject { |square| square.piece.same_color?(self) || square.empty? }
  end

  def attacked_up(board)
    row, column = algebraic_to_array(position)
    board = board.board

    left_square = board[row - 1][column - 1]
    right_square = board[row - 1][column + 1]

    [left_square, right_square].compact
  end

  def attacked_down(board)
    row, column = algebraic_to_array(position)
    board = board.board

    left_square = board[row + 1][column - 1]
    right_square = board[row + 1][column + 1]

    [left_square, right_square].compact
  end
end
