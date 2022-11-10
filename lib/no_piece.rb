require_relative 'piece'

# This class represents a Null Piece Object to give
# default behaviour to the absence of a Piece
class NoPiece < Piece
  attr_reader :position, :color, :symbol

  def initialize(position, color)
    super
    @symbol = '   '
  end
end
