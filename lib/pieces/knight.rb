require_relative '../chess'
# This class describes a Knight piece
class Knight < Piece
  MOVES = [[-2, -1], [-2, 1], [-1, -2], [-1, 2],
           [1, -2], [1, 2], [2, -1], [2, 1]].freeze

  def attacking(board)
    board.find_single_moves(position, MOVES)
  end

  def possible_moves(board)
    attacking(board).reject { |square| forbidden_move(board, square, self) }
  end

  def attacking_paths(board)
    available_paths(board).map { |path| piece_scope(path) }
  end

  def minor_piece?
    true
  end

  def directions
    MOVES
  end
end
