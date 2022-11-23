require_relative 'chess'
# This class represents a chess piece
# Specific pieces are descendent from it
class Piece
  include Directions
  include MoveChecker
  attr_reader :color, :symbol, :position, :fen_value

  def self.for(fen, position)
    case fen
    when 'K'
    when 'Q' then Queen.new(position, 'white', fen)
    when 'R' then Rook.new(position, 'white', fen)
    when 'B' then Bishop.new(position, 'white', fen)
    when 'N' then Knight.new(position, 'white', fen)
    when 'P' then Pawn.new(position, 'white', fen)
    when 'k'
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
  end

  def movable?(board)
    return if off_board?

    !possible_moves(board).empty?
  end

  def attacking(board)
    possible_moves(board)
  end

  def possible_moves(board)
    available_paths(board).map { |path| allowed_moves(path, self) }.flatten
  end

  def update_position(new_position)
    @position = new_position
  end

  def same_color?(other)
    color == other.color
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
