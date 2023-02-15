require_relative '../chess'
# This class represents a chess piece
# Specific pieces are descendent from it
class Piece
  attr_reader :position, :fen_value, :directions, :steps

  FEN_INFO = {
    'K' => { class: 'King', symbol: ' ♔ ', color: 'white' },
    'k' => { class: 'King', symbol: ' ♚ ', color: 'black' },
    'Q' => { class: 'Queen', symbol: ' ♕ ', color: 'white' },
    'q' => { class: 'Queen', symbol: ' ♛ ', color: 'black' },
    'R' => { class: 'Rook', symbol: ' ♖ ', color: 'white' },
    'r' => { class: 'Rook', symbol: ' ♜ ', color: 'black' },
    'B' => { class: 'Bishop', symbol: ' ♗ ', color: 'white' },
    'b' => { class: 'Bishop', symbol: ' ♝ ', color: 'black' },
    'N' => { class: 'Knight', symbol: ' ♘ ', color: 'white' },
    'n' => { class: 'Knight', symbol: ' ♞ ', color: 'black' },
    'P' => { class: 'Pawn', symbol: ' ♙ ', color: 'white' },
    'p' => { class: 'Pawn', symbol: ' ♟︎ ', color: 'black' },
    ' ' => { class: 'NoPiece', symbol: '   ', color: nil }
  }.freeze

  DIAGONAL = {
    up_right: [-1, 1],
    up_left: [-1, -1],
    down_right: [1, 1],
    down_left: [1, -1]
  }.freeze

  HORIZONTAL_VERTICAL = {
    right: [0, 1],
    left: [0, -1],
    up: [-1, 0],
    down: [1, 0]
  }.freeze

  ALL_DIRECTIONS = DIAGONAL.merge(HORIZONTAL_VERTICAL)

  def self.for(position, fen)
    class_name = Object.const_get(FEN_INFO[fen][:class])

    class_name.new(position, fen)
  end

  def initialize(position, fen_value)
    @position = position
    @fen_value = fen_value
    @steps = Board::SIZE

    post_initialize
  end

  def post_initialize; end

  def possible_moves(board)
    MoveSet.legal_moves(board, self)
  end

  def attacking(board)
    MoveSet.attacking(board, self)
  end

  def available_paths(board)
    attacking_paths(board)
  end

  def attacking_paths(board)
    directions.map { |direction| Path.new(board, position, direction, steps:) }
  end

  def movable?(board)
    !possible_moves(board).empty?
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

  def nil?
    false
  end

  def minor_piece?
    false
  end

  def color
    FEN_INFO[fen_value][:color]
  end

  private

  def to_s
    FEN_INFO[fen_value][:symbol]
  end
end
