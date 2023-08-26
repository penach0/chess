require_relative 'chess'
# This class represents a player of a chess game
class Player
  attr_reader :name, :color

  def initialize(color, name)
    @color = color
    @name = name || UserInput.ask_name(color)
  end

  def without_moves?(board)
    movable_pieces(board).empty?
  end

  def fen_value
    color == 'white' ? 'w' : 'b'
  end

  private

  def movable_pieces(board)
    pieces(board).select { |piece| piece.movable?(board) }
  end

  def pieces(board)
    board.pieces(color)
  end
end
