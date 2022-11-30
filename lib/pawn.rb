require_relative 'chess'
# This class represents a Pawn chess piece
class Pawn < Piece
  attr_reader :first_move

  ATTACKING_MOVES = [DIAGONAL[:up_right], DIAGONAL[:up_left]].freeze

  FORWARD_MOVES = HORIZONTAL_VERTICAL[:up]

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
    allowed_forward(board) + possible_captures(board)
  end

  def allowed_forward(board)
    full_path = board.path_in_direction(position, FORWARD_MOVES)[0..1]
    first_square, second_square = full_path

    return [] if first_square.occupied?
    return [first_square] if second_square.occupied?
    return full_path if first_move

    [first_square]
  end

  def possible_captures(board)
    attacked_squares = attacking(board)

    attacked_squares.reject { |square| square.piece.same_color?(self) || square.empty? }
  end

  def attacking(board)
    board.find_single_moves(position, ATTACKING_MOVES)
  end
end
