require_relative '../chess'
# This class represents a chess piece
# Specific pieces are descendent from it
class Piece
  include FENTranslator
  attr_reader :color, :symbol, :position, :fen_value

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
    case fen
    when 'K' then King.new(position, fen)
    when 'Q' then Queen.new(position, fen)
    when 'R' then Rook.new(position, fen)
    when 'B' then Bishop.new(position, fen)
    when 'N' then Knight.new(position, fen)
    when 'P' then Pawn.new(position, fen)
    when 'k' then King.new(position, fen)
    when 'q' then Queen.new(position, fen)
    when 'r' then Rook.new(position, fen)
    when 'b' then Bishop.new(position, fen)
    when 'n' then Knight.new(position, fen)
    when 'p' then Pawn.new(position, fen)
    else NoPiece.new(position, fen)
    end
  end

  def initialize(position, fen_value)
    @position = position
    @fen_value = fen_value
    @color = fen_info(fen_value, :color)
    @symbol = fen_info(fen_value, :symbol)
  end

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
    directions.map { |direction| Path.new(board, position, direction) }
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

  private

  def to_s
    symbol
  end
end
