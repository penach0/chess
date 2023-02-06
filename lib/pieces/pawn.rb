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
    super

    @first_move = false if first_move
  end

  def available_paths(board)
    [forward_path(board), capturing_paths(board)].flatten
  end

  def forward_path(board)
    steps = (first_move ? 2 : 1)

    Path.new(board, position, forward_direction, steps:).free_squares
  end

  def capturing_paths(board)
    attacking_paths(board).select { |path| path.blocked_by?(opponent_color) }
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
