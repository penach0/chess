require_relative 'coordinates'
# This class represents a chess piece
# Specific pieces are descendent from it
class Piece
  include Coordinates
  attr_reader :symbol

  def self.for(symbol, position)
    case symbol
    when ' ♗ '
      Bishop.new(position, 'white')
    when ' ♝ '
      Bishop.new(position, 'black')
    else
      NoPiece.new(position, nil)
    end
  end

  def initialize(position, color)
    @position = position
    @color = color
  end

  def update_position(new_position)
    @position = new_position
  end

  def possible_moves(board)
    available_paths(board).map do |path|
      allowed_moves(path, self)
    end
  end

  def can_move?(board)
    !possible_moves(board).empty?
  end

  def null?
    !color
  end

  def captured
    @position = nil
  end

  def to_s
    symbol
  end

  protected

  def same_color?(other)
    color == other.color
  end
end
