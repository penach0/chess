require_relative '../chess'
# This class represents a Null Piece Object to give
# default behaviour to the absence of a Piece
class NoPiece < Piece
  def nil?
    true
  end
end
