require_relative '../chess'
# This class represents a Queen piece
class Queen < Piece
  MOVES = ALL_DIRECTIONS.values

  def initialize(position, color, fen_value)
    super
    @symbol = (color == 'white' ? ' ♕ ' : ' ♛ ')
  end

  def available_paths(board)
    board.find_paths(position, MOVES)
  end
end
