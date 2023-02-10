require_relative 'chess'
# This class validates user input for moves
class MoveValidator
  attr_reader :board, :player, :start

  def self.valid_start?(board, player, input)
    piece_picked = board.piece_in(input)

    piece_picked.color == player.color && piece_picked.movable?(board)
  end

  def initialize(board, player, start)
    @board = board
    @player = player
  end

  def valid_destination?(input)
    possible_moves = board.piece_in(start).possible_moves(board)
    destination = board.square(input)

    possible_moves.include?(destination)
  end
end