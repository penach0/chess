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

  def king?(passed_color)
    is_a?(King) && color == passed_color
  end

  def same_color?(other)
    color == other.color
  end

  def opponent_color
    color == 'white' ? 'black' : 'white'
  end

  def null?
    !color
  end

  def captured
    @position = nil
  end

  private

  def off_board?
    !position
  end

  def to_s
    symbol
  end
end
