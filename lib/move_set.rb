require_relative 'chess'
# This class represents a collection of all of a piece's legal moves.
# It will do work on finding moves and validating them
class MoveSet
  attr_reader :board, :starting_position, :piece

  def initialize(board, coordinate, piece)
    @starting_position = coordinate
    @piece = piece
    @board = board
  end

  def available_paths
    piece.directions
         .map { |direction| Path.new(board, starting_position, direction) }
  end
end
