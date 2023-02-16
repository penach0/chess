require_relative '../chess'
# This class represents a King chess piece
class King < Piece
  attr_reader :first_move

  CASTLING_DIRECTIONS = {
    queen_side: HORIZONTAL_VERTICAL[:left],
    king_side: HORIZONTAL_VERTICAL[:right]
  }.freeze

  def post_initialize
    @movement = { attacking: ALL_DIRECTIONS.values }
    @steps = 1
    @first_move = true
  end

  def update_position(new_position)
    super

    @first_move = false if first_move
  end

  def in_check?(board)
    attacked_squares = board.squares_attacked_by(opponent_color)

    attacked_squares.any? { |square| square.coordinate == position }
  end
end
