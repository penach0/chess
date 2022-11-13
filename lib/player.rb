require_relative 'chess'
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

  def movable_pieces(board)
    pieces.select { |piece| piece.can_move?(board) }
  end

  def piece_positions(pieces_needed = pieces)
    pieces_needed.map(&:position)
  end

  def make_move(board)
    Move.execute(board, self)
  end
end
