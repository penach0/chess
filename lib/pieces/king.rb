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
    @position = new_position

    @first_move = false if first_move
  end

  def possible_moves(board)
    attacking(board).reject { |square| forbidden_move(board, square, self) }
  end

  def in_check?(board)
    attacked_squares = board.squares_attacked_by(opponent_color)

    attacked_squares.any? { |square| square.coordinate == position }
  end

  def attacking(board)
    board.find_single_moves(position, MOVES)
  end

  def movable?(board)
    return if off_board?

    !possible_moves(board).empty?
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
end
