require_relative 'chess'
# This class represents a Pawn chess piece
class Pawn < Piece
  attr_reader :first_move

  ATTACKING_DIRECTIONS = { 'white' => [[-1, -1], [-1, 1]],
                           'black' => [[1, -1], [1, 1]] }.freeze

  FORWARD_DIRECTIONS = { 'white' => [-1, -2], 'black' => [1, 2] }.freeze

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

  def forward_path(board)
    row, column = algebraic_to_array(position)
    board = board.board
    direction = FORWARD_DIRECTIONS[color]

    first_square = board[row + direction[0]][column]
    second_square = board[row + direction[1]][column]

    [first_square, second_square]
  end

  def allowed_forward(board)
    full_path = forward_path(board)
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
    row, column = algebraic_to_array(position)
    board = board.board
    directions = ATTACKING_DIRECTIONS[color]
    attacked = []

    directions.each do |direction|
      next unless valid_position?(row + direction[0], column + direction[1])

      attacked << board[row + direction[0]][column + direction[1]]
    end

    attacked
  end
end
