require_relative 'chess'
# This class represents a Rook piece
class Rook < Piece
  attr_reader :first_move

  def initialize(position, color, fen_value)
    super
    @symbol = (color == 'white' ? ' ♖ ' : ' ♜ ')
    @first_move = true
  end

  def update_position(new_position)
    super

    @first_move = false if first_move
  end

  def available_paths(board)
    board.find_paths(position, :straight_lines)
  end
end
