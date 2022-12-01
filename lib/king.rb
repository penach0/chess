require_relative 'chess'
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
    @symbol = (color == 'white' ? ' ♔ ' : ' ♚ ')
    @first_move = true
  end

  def update_position(new_position)
    super

    @first_move = false if first_move
  end

  def possible_moves(board)
    (super + possible_castling(board)) - forbidden_squares(board)
  end

  def attacking(board)
    board.find_single_moves(position, MOVES)
  end

  def castling_path(board)
    board.find_paths(position, CASTLING_DIRECTIONS.values)
  end

  def possible_castling(board)
    castling_path(board).filter_map do |path|
      rook = path.pop.piece
      king_landing_square = path[1]

      king_landing_square if can_castle?(board, rook, path)
    end
  end

  def forbidden_squares(board)
    board.squares_attacked_by(opponent_color)
  end

  def can_castle?(board, rook, path)
    return false if rook.null?

    castling_possible?(rook, path) && castling_safe?(board, path)
  end

  def castling_possible?(rook, path)
    [self, rook].all?(&:first_move) && path_empty?(path)
  end

  def castling_safe?(board, path)
    forbidden_squares = forbidden_squares(board)
    king_path = path[0..1]

    king_path.none? { |square| forbidden_squares.include?(square) }
  end
end
