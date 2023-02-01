require_relative '../chess'

# This class represents a Null Piece Object to give
# default behaviour to the absence of a Piece
class NoPiece < Piece
  def same_color?(other)
    color == other.color
  end

  def null?
    true
  end

  def captured
    @position = nil
  end

  private

  def off_board?
    !position
  end
end
