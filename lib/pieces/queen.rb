require_relative '../chess'
# This class represents a Queen piece
class Queen < Piece
  MOVES = ALL_DIRECTIONS.values

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

  def available_paths(board)
    board.find_paths(position, MOVES)
  end

  def king?(passed_color)
    is_a?(King) && color == passed_color
  end

  def update_position(new_position)
    @position = new_position
  end

  def same_color?(other)
    color == other.color
  end

  def opponent_color
    color == 'white' ? 'black' : 'white'
  end

  def captured
    @position = nil
  end

  private

  def off_board?
    !position
  end
end
