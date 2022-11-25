require_relative 'chess'
# This class represents a King chess piece
class King < Piece
  attr_reader :first_move

  MOVES = [[-1, -1], [-1, 0], [-1, 1],
           [0, -1], [0, 1],
           [1, -1], [1, 0], [1, 1]].freeze

  CASTLE = [[0, -2], [0, 2]].freeze

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
    super - board.squares_attacked_by(opponent_color)
  end

  def attacking(board)
    board.find_single_moves(position, MOVES)
  end

  def castle(board)
    return [] unless can_castle?

    queen_side, king_side = board.find_single_moves(position, CASTLE)
  end

  def can_castle?(rook)
    [self, rook].all?(&:first_move)
  end

  def find_closest_rook(board, direction)
    
  end
end
