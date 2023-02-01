require_relative '../chess'
# This class represents a chess piece
# Specific pieces are descendent from it
class Piece
  # include PathFinder
  include MoveChecker
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

  def self.for(fen, position)
    case fen
    when 'K' then King.new(position, 'white', fen)
    when 'Q' then Queen.new(position, 'white', fen)
    when 'R' then Rook.new(position, 'white', fen)
    when 'B' then Bishop.new(position, 'white', fen)
    when 'N' then Knight.new(position, 'white', fen)
    when 'P' then Pawn.new(position, 'white', fen)
    when 'k' then King.new(position, 'black', fen)
    when 'q' then Queen.new(position, 'black', fen)
    when 'r' then Rook.new(position, 'black', fen)
    when 'b' then Bishop.new(position, 'black', fen)
    when 'n' then Knight.new(position, 'black', fen)
    when 'p' then Pawn.new(position, 'black', fen)
    else NoPiece.new(position, nil, fen)
    end
  end

  def initialize(position, color, fen_value)
    @position = position
    @color = color
    @fen_value = fen_value
    @symbol = FEN_TO_SYMBOL[fen_value]
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

  def null?
    false
  end

  private

  def to_s
    symbol
  end
end
