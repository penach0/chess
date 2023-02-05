require_relative '../chess'
# This class represents a Pawn chess piece
class Pawn < Piece
  attr_reader :first_move

  ATTACKING_MOVES = {
    'white' => [DIAGONAL[:up_right], DIAGONAL[:up_left]],
    'black' => [DIAGONAL[:down_right], DIAGONAL[:down_left]]
  }.freeze

  FORWARD_MOVES = {
    'white' => HORIZONTAL_VERTICAL[:up],
    'black' => HORIZONTAL_VERTICAL[:down]
  }.freeze

  def initialize(position, fen_value)
    super
    @first_move = true
  end

  def update_position(new_position)
    @position = new_position

    @first_move = false if first_move
  end

  def possible_moves(board)
    available_squares = allowed_forward(board) + possible_captures(board)

    available_squares.reject { |square| moves_into_check?(board, square, self) }
  end

  def allowed_forward(board)
    full_path = board.path_in_direction(position, forward_direction)[0..1]
    first_square, second_square = full_path

    return [] if first_square.occupied?
    return full_path if first_move && second_square.empty?

    [first_square]
  end

  def forward_path(board)
    steps = (first_move ? 2 : 1)

    Path.new(board, position, forward_direction, steps:).free_squares
  end

  def possible_captures(board)
    attacked_squares = attacking(board)

    attacked_squares.select { |square| square.occupied?(opponent_color) }
  end

  def attacking(board)
    MoveSet.attacking(board, self)
  end

  def attacking_paths(board)
    attacking_directions.map { |direction| Path.new(board, position, direction, steps: 1) }
  end

  def attacking_directions
    ATTACKING_MOVES[color]
  end

  def forward_direction
    FORWARD_MOVES[color]
  end
end
