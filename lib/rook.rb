require_relative 'chess'
# This class represents a Rook piece
class Rook < Piece
  def initialize(position, color, fen_value)
    super
    @symbol = (color == 'white' ? ' ♖ ' : ' ♜ ')
  end

  def available_paths(board)
    find_paths(position, board.straight_lines)
  end
end
