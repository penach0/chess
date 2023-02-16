require_relative '../chess'
# This class represents a Pawn chess piece
class Pawn < Piece
  attr_reader :first_move

  ATTACKING = {
    'white' => [DIAGONAL[:up_right], DIAGONAL[:up_left]],
    'black' => [DIAGONAL[:down_right], DIAGONAL[:down_left]]
  }.freeze

  FORWARD = {
    'white' => HORIZONTAL_VERTICAL[:up],
    'black' => HORIZONTAL_VERTICAL[:down]
  }.freeze

  def post_initialize
    @first_move = true
    @movement = { attacking: ATTACKING[color], forward: FORWARD[color] }
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

    Path.new(board, position, movement[:forward], steps:)
  end

  def capturing_paths(board)
    attacking_paths(board).select { |path| path.blocked_by?(opponent_color) }
  end

  def attacking_paths(board)
    movement[:attacking].map { |direction| AttackingPath.new(board, position, direction, steps: 1) }
  end
end
