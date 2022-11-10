require_relative 'move'
# This class represents a player of a chess game
class Player
  attr_reader :color, :pieces

  def initialize(color)
    @color = color
    @pieces = create_pieces
  end

  def create_pieces
    if color == 'black'
      [Bishop.new('a7', color)]
    else
      [Bishop.new('b2', color),
       Bishop.new('d4', color)]
    end
  end

  def place_pieces(board)
    pieces.each { |piece| board.place_piece(piece) }
  end

  def make_move(board)
    Move.execute(board, self)
  end
end
