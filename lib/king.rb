require_relative 'chess'
# This class represents a King chess piece
class King < Piece
  attr_reader :first_move

  MOVES = [[-1, -1], [-1, 0], [-1, 1],
           [0, -1], [0, 1],
           [1, -1], [1, 0], [1, 1]].freeze

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
    all_moves = attacking(board)
    forbidden_squares = board.squares_attacked_by(opponent_color)

    all_moves.reject do |square|
      square.piece.same_color?(self) || forbidden_squares.include?(square)
    end
  end

  def attacking(board)
    board.single_move_finder(position, MOVES)
  end
end
