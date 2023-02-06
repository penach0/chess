require_relative '../chess'
# This class represents a Queen piece
class Queen < Piece
  MOVES = ALL_DIRECTIONS.values

  def directions
    MOVES
  end
end
