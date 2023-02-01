require_relative '../chess'
# This class represents a King chess piece
class King < Piece
  attr_reader :first_move

  MOVES = ALL_DIRECTIONS.values

  CASTLING_DIRECTIONS = {
    queen_side: HORIZONTAL_VERTICAL[:left],
    king_side: HORIZONTAL_VERTICAL[:right]
  }.freeze

  def initialize(position, color, fen_value)
    super
    @first_move = true
  end

  def update_position(new_position)
    super

    @first_move = false if first_move
  end

  def possible_moves(board)
    (super + possible_castling(board)) - forbidden_squares(board)
  end

  def in_check?(board)
    forbidden_squares(board).any? { |square| square.coordinate == position }
  end

  def attacking(board)
    board.find_single_moves(position, MOVES)
  end
end
