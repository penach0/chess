require_relative 'piece'

# This class represents a Null Piece Object to give
# default behaviour to the absence of a Piece
class NoPiece < Piece

  def initialize(position, color, fen_value)
    super
    @symbol = '   '
  end
end
