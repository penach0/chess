require_relative '../chess'
# This class represents a Rook piece
class Rook < Piece
  attr_reader :first_move

  MOVES = HORIZONTAL_VERTICAL.values

  def initialize(position, fen_value)
    super
    @first_move = true
  end

  def update_position(new_position)
    @position = new_position

    @first_move = false if first_move
  end

  def possible_moves(board)
    MoveSet.legal_moves(board, self)
  end

  def attacking(board)
    MoveSet.attacking(board, self)
  end

  def directions
    MOVES
  end
end
