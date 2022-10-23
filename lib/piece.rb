# This class represents a chess piece
# Specific pieces are descendent from it
class Piece
  def initialize(position, color)
    @position = position
    @color = color
  end

  def move(new_position)
    @position = new_position
  end
end
