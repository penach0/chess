require_relative 'chess'
# This class represents a King chess piece
class King < Piece
  attr_reader :first_move

  def initialize(position, color, fen_value)
    super
    @symbol = (color == 'white' ? ' ♔ ' : ' ♚ ')
    @first_move = true
  end

  def update_position(new_position)
    super

    @first_move = false if first_move
  end

  def possible_moves(board)
    available_squares(board) - board.squares_attacked_by(opponent_color)
  end

  def available_squares(board)
    find_paths(position, all_directions(board)).map(&:first)
  end
end
