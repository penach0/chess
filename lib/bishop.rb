require_relative 'piece'
require_relative 'directions'
require_relative 'move_checker'

# This class represents a bishop chess piece
class Bishop < Piece
  include Directions
  include MoveChecker
  attr_reader :color, :symbol, :position

  def self.for(symbol, position)
    case symbol
    when ' ♗ '
      new(position, 'white')
    when ' ♝ '
      new(position, 'black')
    else
      symbol
    end
  end

  def initialize(position, color)
    @color = color
    @position = position
    @symbol = (color == 'white' ? ' ♗ ' : ' ♝ ')
  end

  def available_paths(board)
    diagonals(board.board).find_all do |diagonal|
      find_diagonals(diagonal)
    end
  end


end
