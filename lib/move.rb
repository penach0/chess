require_relative 'move_checker'
# This class will describe a move to be made by a player
class Move
  include MoveChecker
  attr_reader :board, :player, :starting, :ending

  def self.execute(board, player)
    new(board, player).execute
  end

  def initialize(board, player)
    @board = board
    @player = player
    @starting = starting_validation(ask_coordinate(:start_square))
    @ending = ending_validation(ask_coordinate(:end_square))
  end

  def starting_validation(coordinate)
    return coordinate if valid_starting?(coordinate)

    starting_validation(ask_coordinate(:invalid_coordinate))
  end

  def ending_validation(coordinate)
    return coordinate if valid_ending?(coordinate)

    ending_validation(ask_coordinate(:invalid_coordinate))
  end

  def valid_starting?(coordinate)
    board.square(coordinate).occupied?(player.color)
  end

  def valid_ending?(coordinate)
    possible_moves(starting).include?(coordinate)
  end

  def possible_moves(starting)
    board.piece_in(starting).possible_moves(board)
  end

  def execute
    board.move_piece(starting, ending)
  end
end
