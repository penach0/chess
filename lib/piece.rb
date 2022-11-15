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
    when 'Q'
    when 'R' then Rook.new(position, 'white', fen)
    when 'B' then Bishop.new(position, 'white', fen)
    when 'N'
    when 'P'
    when 'k'
    when 'q'
    when 'r' then Rook.new(position, 'black', fen)
    when 'b' then Bishop.new(position, 'black', fen)
    when 'n'
    when 'p'
    else NoPiece.new(position, nil, fen)
    end
  end

  def initialize(position, color, fen_value)
    @position = position
    @color = color
    @fen_value = fen_value
  end

  def update_position(new_position)
    @position = new_position
  end

  def possible_moves(board)
    available_paths(board).map { |path| allowed_moves(path, self) }.flatten
  end

  def movable?(board)
    !possible_moves(board).empty?
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

  def to_s
    symbol
  end
end
