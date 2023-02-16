require_relative '../chess'
# This class represents a Rook piece
class Rook < Piece
  attr_reader :first_move

  def post_initialize
    @movement = { attacking: HORIZONTAL_VERTICAL.values }
    @first_move = true
  end

  def update_position(new_position)
    super

    @first_move = false if first_move
  end
end
