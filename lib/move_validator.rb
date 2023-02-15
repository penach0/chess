require_relative 'chess'
# This class validates user input for moves
class MoveValidator
  attr_reader :board, :player, :start, :moves

  def self.validate_start(board, player, input)
    return input if valid_start?(board, player, input)

    validate_start(board, player, UserInput.ask_coordinate(:invalid, input: 'coordinate'))
  end

  def self.valid_start?(board, player, input)
    coordinate = Coordinate.new(algebraic: input)
    picked_piece = board.piece_in(coordinate)

    picked_piece.color == player.color && !MoveGenerator.new(board, coordinate).legal_moves.empty?
  end

  def self.validate_destination(board, player, start, input)
    new(board, player, start).validate_destination(input)
  end

  def initialize(board, player, start)
    @board = board
    @player = player
    @moves = MoveGenerator.new(board, Coordinate.new(algebraic: start)).legal_moves
  end

  def validate_destination(input)
    return input if valid_destination?(input)

    validate_destination(UserInput.ask_coordinate(:invalid, input: 'coordinate'))
  end

  def valid_destination?(input)
    possible_destinations = moves.map(&:to)
                                 .map(&:algebraic)

    possible_destinations.include?(input)
  end
end
