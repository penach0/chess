require_relative 'chess'
# This class represents a Queen piece
class Queen < Piece
  def initialize(position, color, fen_value)
    super
    @symbol = (color == 'white' ? ' ♕ ' : ' ♛ ')
  end

  def available_paths(board)
    find_paths(position, all_directions(board.board))
  end
end
