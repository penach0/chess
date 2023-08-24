require_relative 'chess'
# This class validates user input for moves
class MoveValidator
  attr_reader :board, :player, :start, :moves

  def self.validate_start(board, player, input)
    coordinate = Coordinate.from_string(input)

    return coordinate if valid_start?(board, player, coordinate)

    validate_start(board, player, UserInput.ask_coordinate(:invalid, input: 'coordinate'))
  end

  def self.valid_start?(board, player, coordinate)
    return false unless board.inside_board?(coordinate)

    picked_piece = board.piece_in(coordinate)

    picked_piece.color == player.color && !MoveGenerator.new(board, coordinate).legal_moves.empty?
  end

  def self.validate_destination(board, player, start, input)
    new(board, player, start).validate_destination(input)
  end

  def initialize(board, player, start)
    @board = board
    @player = player
    @start = start
  end

  def validate_destination(input)
    coordinate = Coordinate.from_string(input)

    return coordinate if valid_destination?(coordinate)

    validate_destination(UserInput.ask_coordinate(:invalid, input: 'coordinate'))
  end

  def valid_destination?(coordinate)
    possible_moves = MoveGenerator.new(board, start).legal_moves

    possible_destinations = possible_moves.map(&:to)

    possible_destinations.include?(coordinate)
  end
end
