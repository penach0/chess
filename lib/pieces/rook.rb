require_relative '../chess'
# This class represents a Rook piece
class Rook < Piece
  attr_reader :first_move

  MOVES = HORIZONTAL_VERTICAL.values

  def initialize(position, color, fen_value)
    super
    @first_move = true
  end

  def update_position(new_position)
    @position = new_position

    @first_move = false if first_move
  end

  def available_paths(board)
    board.find_paths(position, MOVES)
  end

  def possible_moves(board)
    attacking(board).reject { |square| forbidden_move(board, square, self) }
  end

  def attacking(board)
    attacking_paths(board).flatten
  end

  def attacking_paths(board)
    available_paths(board).map { |path| piece_scope(path) }
  end
end
