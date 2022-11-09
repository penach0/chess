require_relative 'piece'
require_relative 'directions'
require_relative 'move_checker'

# This class represents a bishop chess piece
class Bishop
  include Directions
  include MoveChecker
  attr_reader :color, :symbol
  attr_accessor :position

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

  def possible_moves(board)
    available_paths(board).map do |path|
      allowed_moves(path, color, position)
    end
  end

  def can_move?(board)
    !possible_moves(board).empty?
  end

  def update_position(new_position)
    @position = new_position
  end

  def to_s
    symbol
  end
end
