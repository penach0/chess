require_relative '../chess'
# This class represents a King chess piece
class King < Piece
  attr_reader :first_move

  MOVES = ALL_DIRECTIONS.values

  CASTLING_DIRECTIONS = {
    queen_side: HORIZONTAL_VERTICAL[:left],
    king_side: HORIZONTAL_VERTICAL[:right]
  }.freeze

  def initialize(position, fen_value)
    super
    @first_move = true
  end

  def possible_moves(board)
    MoveSet.legal_moves(board, self)
  end

  def attacking(board)
    MoveSet.attacking(board, self)
  end

  def attacking_paths(board)
    directions.map { |direction| Path.new(board, position, direction, steps: 1) }
  end

  def update_position(new_position)
    @position = new_position

    @first_move = false if first_move
  end

  def in_check?(board)
    attacked_squares = board.squares_attacked_by(opponent_color)

    attacked_squares.any? { |square| square.coordinate == position }
  end

  def directions
    MOVES
  end
end
