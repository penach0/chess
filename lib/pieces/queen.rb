require_relative '../chess'
# This class represents a Queen piece
class Queen < Piece
  def post_initialize
    @directions = ALL_DIRECTIONS.values
  end
end
