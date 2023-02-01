require_relative '../chess'
# This class represents a bishop chess piece
class Bishop < Piece
  MOVES = DIAGONAL.values

  def available_paths(board)
    board.find_paths(position, MOVES)
  end

  def movable?(board)
    return if off_board?

    !possible_moves(board).empty?
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

  private

  def off_board?
    !position
  end
end
