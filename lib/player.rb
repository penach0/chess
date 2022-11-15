require_relative 'chess'
# This class represents a player of a chess game
class Player
  include UserInput
  attr_reader :color, :pieces, :name

  def initialize(color, board, name = ask_name(color))
    @name = name
    @color = color
    @pieces = fetch_pieces(board)
  end

  def movable_pieces(board)
    pieces.select { |piece| piece.movable?(board) }
  end

  def piece_positions(pieces_needed = pieces)
    pieces_needed.map(&:position)
  end

  def make_move(board)
    Move.execute(board, self)
  end

  private

  def fetch_pieces(board)
    board.pieces_of_color(color)
  end
end
