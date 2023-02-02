require_relative 'chess'
# This class represents a player of a chess game
class Player
  include UserInput
  attr_reader :name, :color

  def initialize(color, name = ask_name(color))
    @color = color
    @name = name
  end

  def no_moves?(board)
    movable_pieces(board).empty?
  end

  def movable_pieces(board)
    pieces(board).select { |piece| piece.movable?(board) }
  end

  def make_move(board)
    Move.execute(board, self)
  end

  private

  def pieces(board)
    board.pieces(color)
  end
end
