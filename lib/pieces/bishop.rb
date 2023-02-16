require_relative '../chess'
# This class represents a bishop chess piece
class Bishop < Piece
  def post_initialize
    @movement = { attacking: DIAGONAL.values }
  end

  def minor_piece?
    true
  end
end
