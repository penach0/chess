require_relative 'move'
# This class represents a player of a chess game
class Player
  attr_reader :color, :pieces

  def initialize(color, board)
    @color = color
    @pieces = fetch_pieces(board)
  end

  def fetch_pieces(board)
    board.pieces_of_color(color)
  end

  def make_move(board)
    Move.execute(board, self)
  end
end
